#!/usr/bin/env python3
"""
Generate multi-line tile images for lines in a text file, matching the game's word-wrap logic.

Usage:
  python generate_images.py SG/GAMEMSGS.INC

Note: This script expects the game's message include format (e.g., `SG/GAMEMSGS.INC`). It is a single-purpose, vibe slop utility to inspect layout and spacing of in-game communication messages.

Summary:
 - Parses lines of the form: `message <speaker, ...>,<text>,...` and extracts the first `<...>` text segment as the message. Legacy lines that start with `<...>` are also supported.
 - Word-wrap attempts to mimic SG/MTXTPRT.MC behavior (default LINE_WIDTH_LIMIT=94 px, tunable).
 - Uses 8x8 PNG tiles for glyphs (A.png, B.png, etc). Special symbols are mapped via `SPECIAL_MAP` (eg "'" -> exclaim.png, '!' -> woo.png, '#' -> dot.png).
 - Space width is `SPACE_WIDTH` (5 px). Per-character advance follows `CHAR_ADVANCE` plus narrow-character exceptions and special cases.
 - Variant tiles: the renderer prefers `<glyph>b.png` (black) for the shadow and `<glyph>w.png` (white) for the main glyph when available; use `tools/eo_comms/make_bw_tiles.py --tiles <dir>` to generate these variants.
 - Shadow/main drawing: shadow is pasted offset by (+1, +1) behind the main text.
 - Speaker portrait overlay: if a speaker image such as `fox.png` exists in the tiles directory it will be pasted at (58,160) behind the text.
 - Baseline rules: if the original speaker token ended with '3' (eg `falcon3`) the text baseline is (90,160); otherwise the baseline is shifted down to (90,173). When no background is provided the canvas-local baselines are (0,0) or (0,13) respectively. The shadow is always main + (1,1).
 - Output: numbered PNGs are written to `output`; 2x nearest-neighbor scaled copies are written to a sibling `output2x` directory. In `--debug` mode the script writes per-character position logs (`{n}.debug.txt`) and a debug overlay image (`{n}_dbg.png`).
 - The script auto-detects a tiles directory (common locations include `tools/eo_comms/img`). Unicode whitespace is normalized and treated as spaces to avoid missing-tile placeholders.

Behavior:
 - Reads the input file line-by-line, wraps text into lines matching the game's logic, composes images using tiles, and writes debug/log files when requested.
"""

import os
import sys
import argparse
from PIL import Image, ImageDraw
import unicodedata, re
import shutil

# Constants matching the game's MTXTPRT.MC (modified for testing)
LINE_WIDTH_LIMIT = 94  # reduced from 128 to test tighter wrapping
SPACE_WIDTH = 5         # spacewid equ 5
TILE_HEIGHT = 8         # 8x8 tiles
LINE_SPACING = 5        # gap between lines (increased by 4px)
# Default character advance for non-narrow glyphs (adjusted to 6px)
CHAR_ADVANCE = 6  # pixels

# Narrow characters that advance only 4px instead of CHAR_ADVANCE (7px)
NARROW_CHARS = set("i'#.")


def normalize_char(ch):
    """Try to reduce diacritics and return ascii single-char or '' if none."""
    n = unicodedata.normalize('NFKD', ch)
    try:
        asbytes = n.encode('ascii', 'ignore')
        s = asbytes.decode('ascii')
        return s
    except Exception:
        return ''


SPECIAL_MAP = {
    "'": 'exclaim.png',
    '!': 'woo.png',
    '#': 'dot.png',
    ',': 'com.png',
    '.': 'period.png',
    '?': 'question.png',
    '-': '-.png',
}


def advance_for(ch):
    """Return the pixel advance width for a character.

    Narrow characters use smaller advances; other glyphs advance by CHAR_ADVANCE.
    Special tweaks:
      - Any Unicode whitespace is treated as a space and uses SPACE_WIDTH
      - 'i' and '\'' use 3px
      - other narrow glyphs use 4px
      - 't' and 'm' use CHAR_ADVANCE+1
    """
    if ch.isspace():
        return SPACE_WIDTH
    # tiny-space exceptions: lowercase i and apostrophe
    if ch == 'i' or ch == "'":
        return 3
    # comma uses reduced advance (CHAR_ADVANCE - 3), but at least 1px
    if ch == ',':
        return max(1, CHAR_ADVANCE - 3)
    # '#' slightly narrower: CHAR_ADVANCE - 3 (min 1px)
    if ch == '#':
        return max(1, CHAR_ADVANCE - 3)
    if ch in NARROW_CHARS:
        return 4
    # Special-cases: Some glyphs need one extra pixel to align following glyphs
    if ch in ('t', 'm'):
        return CHAR_ADVANCE + 1
    return CHAR_ADVANCE


def find_tile_file(ch, tiles_dir):
    """Find the tile file for a character, trying multiple naming conventions."""
    if ch.isspace():
        return None

    # Check special mapping first
    if ch in SPECIAL_MAP:
        fname = SPECIAL_MAP[ch]
        path = os.path.join(tiles_dir, fname)
        if os.path.isfile(path):
            return path

    # Try uppercase first (as in the existing tiles like A.png, B.png), then lowercase
    if ch.isalnum():
        for name in [ch.upper() + '.png', ch.lower() + '.png']:
            path = os.path.join(tiles_dir, name)
            if os.path.isfile(path):
                return path

    # Try normalized form (strip accents)
    n = normalize_char(ch)
    if n and n != ch:
        return find_tile_file(n, tiles_dir)

    return None


def find_variant_tile_file(ch, variant, tiles_dir):
    """Find a variant tile (e.g., 'Ab.png' or special name with suffix 'b') or None."""
    # variant is expected to be a short suffix like 'b' or 'w'
    if ch.isspace():
        return None

    # Check special mapping first (insert variant before .png)
    if ch in SPECIAL_MAP:
        base = SPECIAL_MAP[ch]
        stem, ext = os.path.splitext(base)
        for cand in [f"{stem}{variant}{ext}", base]:
            path = os.path.join(tiles_dir, cand)
            if os.path.isfile(path):
                return path

    # alnum: try A + variant, a + variant, then fall back
    if ch.isalnum():
        for name in [ch.upper() + variant + '.png', ch.lower() + variant + '.png', ch.upper() + '.png', ch.lower() + '.png']:
            path = os.path.join(tiles_dir, name)
            if os.path.isfile(path):
                return path

    # Try normalized form
    n = normalize_char(ch)
    if n and n != ch:
        return find_variant_tile_file(n, variant, tiles_dir)

    return None


def load_variant_tile(ch, tiles_dir, tile_cache, variant=None):
    """Load and cache a tile image for a character and optional variant."""
    key = (ch, variant)
    if key in tile_cache:
        return tile_cache[key]

    # Treat any Unicode whitespace as a space (no tile)
    if ch.isspace():
        tile_cache[key] = None
        return None

    path = None
    if variant:
        path = find_variant_tile_file(ch, variant, tiles_dir)
    if not path:
        path = find_tile_file(ch, tiles_dir)
    if path:
        img = Image.open(path).convert('RGBA')
        tile_cache[key] = img
        return img

    # Create placeholder for missing glyphs
    img = Image.new('RGBA', (8, 8), (0, 0, 0, 0))
    draw = ImageDraw.Draw(img)
    draw.rectangle([0, 0, 7, 7], outline=(255, 0, 0, 255))
    draw.line([1, 6, 6, 1], fill=(255, 0, 0, 255))
    tile_cache[key] = img
    return img


def render_lines_variant(lines, tiles_dir, tile_cache, variant=None):
    """Render lines into an image using variant tiles when available.
    variant can be 'b' or 'w' (or None to use originals).
    """
    if not lines:
        return Image.new('RGBA', (1, TILE_HEIGHT), (0, 0, 0, 0))

    max_width = max(sum(item[2] for item in line) for line in lines) if lines else 1
    max_width = max(1, max_width)
    total_height = len(lines) * TILE_HEIGHT + (len(lines) - 1) * LINE_SPACING

    img = Image.new('RGBA', (max_width, total_height), (0, 0, 0, 0))

    y = 0
    for line in lines:
        x = 0
        for ch, tile, adv in line:
            # load variant if requested (falls back to original)
            if variant:
                var_tile = load_variant_tile(ch, tiles_dir, tile_cache, variant)
            else:
                var_tile = tile
            if var_tile is not None:
                img.paste(var_tile, (x, y), var_tile)
            x += adv
        y += TILE_HEIGHT + LINE_SPACING

    return img

def load_tile(ch, tiles_dir, tile_cache):
    """Load and cache a tile image for a character."""
    if ch.isspace():
        return None

    if ch in tile_cache:
        return tile_cache[ch]

    path = find_tile_file(ch, tiles_dir)
    if path:
        img = Image.open(path).convert('RGBA')
        tile_cache[ch] = img
        return img

    # Create placeholder
    img = Image.new('RGBA', (8, 8), (0, 0, 0, 0))
    draw = ImageDraw.Draw(img)
    draw.rectangle([0, 0, 7, 7], outline=(255, 0, 0, 255))
    draw.line([1, 6, 6, 1], fill=(255, 0, 0, 255))
    tile_cache[ch] = img
    return img


def word_wrap(content, tiles_dir, tile_cache):
    """
    Word-wrap text into lines matching the game's algorithm.
    Returns a list of lines, where each line is a list of (char, tile, advance) tuples.
    
    The game's algorithm (from MTXTPRT.MC):
    - Track the last space position
    - When text exceeds LINE_WIDTH_LIMIT, wrap back to last space
    """
    lines = []
    current_line = []
    current_width = 0
    last_space_idx = -1  # index in current_line of last space
    last_space_width = 0  # width at that point

    i = 0
    while i < len(content):
        ch = content[i]
        adv = advance_for(ch)
        tile = load_tile(ch, tiles_dir, tile_cache)

        # Check if adding this character would exceed the line width
        if current_width + adv > LINE_WIDTH_LIMIT and current_line:
            # Need to wrap
            if last_space_idx >= 0:
                # Wrap at last space - keep chars up to (not including) the space
                wrapped_line = current_line[:last_space_idx]
                remaining = current_line[last_space_idx + 1:]  # skip the space itself
                lines.append(wrapped_line)
                current_line = remaining
                current_width = sum(item[2] for item in current_line)
                last_space_idx = -1
                last_space_width = 0
                # Don't increment i - re-process current character
                continue
            else:
                # No space to wrap at - force break
                lines.append(current_line)
                current_line = []
                current_width = 0
                last_space_idx = -1
                last_space_width = 0
                continue

        # Track space positions for word wrapping
        if ch == ' ':
            last_space_idx = len(current_line)
            last_space_width = current_width

        current_line.append((ch, tile, adv))
        current_width += adv
        i += 1

    # Don't forget the last line
    if current_line:
        lines.append(current_line)

    return lines




def render_lines(lines):
    """Render wrapped lines into a single image."""
    if not lines:
        return Image.new('RGBA', (1, TILE_HEIGHT), (0, 0, 0, 0))

    # Calculate dimensions
    max_width = max(sum(item[2] for item in line) for line in lines) if lines else 1
    max_width = max(1, max_width)
    total_height = len(lines) * TILE_HEIGHT + (len(lines) - 1) * LINE_SPACING

    img = Image.new('RGBA', (max_width, total_height), (0, 0, 0, 0))

    y = 0
    for line in lines:
        x = 0
        for ch, tile, adv in line:
            if tile is not None:
                img.paste(tile, (x, y), tile)
            x += adv
        y += TILE_HEIGHT + LINE_SPACING

    return img


def find_tiles_dir():
    """Search common locations for an image tile folder and return its path, or None."""
    script_dir = os.path.dirname(os.path.abspath(__file__))
    candidates = [
        os.path.join(script_dir, 'img'),
        os.path.join(script_dir, 'tiles'),
        os.path.join(os.getcwd(), 'img'),
        os.path.join(os.getcwd(), 'tools', 'eo_comms', 'img'),
    ]
    for c in candidates:
        if os.path.isdir(c):
            for f in os.listdir(c):
                if f.lower().endswith('.png'):
                    return c
    # Walk to find any directory named 'img' containing pngs
    for root, dirs, files in os.walk(os.getcwd()):
        for d in dirs:
            if d.lower() == 'img':
                p = os.path.join(root, d)
                try:
                    for f in os.listdir(p):
                        if f.lower().endswith('.png'):
                            return p
                except Exception:
                    continue
    return None


def process_file(input_path, tiles_dir, out_dir, debug=False):
    os.makedirs(out_dir, exist_ok=True)
    index_lines = []
    counter = 1
    tile_cache = {}

    with open(input_path, 'r', encoding='utf-8') as fh:
        for file_line_no, raw in enumerate(fh, start=1):
            line = raw.rstrip('\n')
            stripped = line.lstrip()

            # Support two input styles:
            # - legacy: lines that start with '<...>'
            # - GAMEMSGS.INC style: lines that start with 'message' and have the first <...> as the text
            content = None
            speaker = None
            has_suffix_3 = False
            if stripped.lower().startswith('message'):
                # extract speaker (text between 'message' and the first comma)
                rest = stripped[len('message'):].lstrip()
                comma = rest.find(',')
                if comma != -1:
                    orig_sp = rest[:comma].strip()
                    # remember whether the original token ended with '3' (eg: 'fox3')
                    has_suffix_3 = orig_sp.endswith('3')
                    # strip trailing digits (eg: 'fox3' -> 'fox') for lookup
                    sp = re.sub(r'\d+$', '', orig_sp)
                    speaker = sp
                # find the first <...> segment
                start = stripped.find('<')
                if start != -1:
                    end = stripped.find('>', start + 1)
                    content = stripped[start + 1:] if end == -1 else stripped[start + 1:end]
            elif stripped.startswith('<'):
                # legacy behaviour
                start = stripped.find('<')
                end = stripped.find('>', start + 1)
                content = stripped[start + 1:] if end == -1 else stripped[start + 1:end]

            if not content:
                continue

            content = content.strip()

            # Word-wrap and render; use black/white variants for shadow and main
            lines = word_wrap(content, tiles_dir, tile_cache)
            # Render shadow (black 'b') and main (white 'w'); variants fall back to originals if absent
            shadow_img = render_lines_variant(lines, tiles_dir, tile_cache, variant='b')
            main_img = render_lines_variant(lines, tiles_dir, tile_cache, variant='w')
            # Use main_img as the reference for width/height (shadow has same dimensions)
            text_img = main_img

            # Try to use bg.png as the background; place text at (90,160)
            bg_path = os.path.join(tiles_dir, 'bg.png') if tiles_dir else None
            if not bg_path or not os.path.isfile(bg_path):
                # fallback to script dir
                script_dir = os.path.dirname(os.path.abspath(__file__))
                alt = os.path.join(script_dir, 'bg.png')
                if os.path.isfile(alt):
                    bg_path = alt
                else:
                    bg_path = None

            # compute per-character positions for debug/logging
            positions = []  # list of lists, one per line, each entry: (ch, x)
            for lineidx, line in enumerate(lines):
                x = 0
                row = []
                for ch, tile, adv in line:
                    row.append((ch, x))
                    x += adv
                positions.append(row)

            if bg_path:
                bg_img = Image.open(bg_path).convert('RGBA')
                paste_x = 90
                base_paste_y = 160
                # If the speaker didn't have the '3' suffix, use the alternate lower baseline (+13 px)
                paste_y = base_paste_y if has_suffix_3 else (base_paste_y + 13)

                # Load speaker character image (if any) and position (absolute)
                char_img = None
                char_x, char_y = 58, 160
                if speaker:
                    for cand in [f"{speaker}.png", f"{speaker.lower()}.png", f"{speaker.capitalize()}.png"]:
                        p = os.path.join(tiles_dir, cand)
                        if os.path.isfile(p):
                            try:
                                char_img = Image.open(p).convert('RGBA')
                                break
                            except Exception:
                                continue

                # Expand background canvas if text or character would overflow (consider offset too)
                new_w = max(bg_img.width, paste_x + text_img.width + 1)
                new_h = max(bg_img.height, paste_y + text_img.height + 1)
                if char_img:
                    new_w = max(new_w, char_x + char_img.width + 1)
                    new_h = max(new_h, char_y + char_img.height + 1)

                if new_w != bg_img.width or new_h != bg_img.height:
                    new_bg = Image.new('RGBA', (new_w, new_h), (0, 0, 0, 0))
                    new_bg.paste(bg_img, (0, 0))
                    bg_img = new_bg

                # Paste the character image (behind the text), then shadow then main on top
                if char_img:
                    bg_img.paste(char_img, (char_x, char_y), char_img)

                bg_img.paste(shadow_img, (paste_x + 1, paste_y + 1), shadow_img)
                bg_img.paste(main_img, (paste_x, paste_y), main_img)
                out_img = bg_img

                # If debug mode, draw vertical lines and labels at character x positions for both copies
                if debug:
                    draw = ImageDraw.Draw(out_img)
                    font = None
                    try:
                        from PIL import ImageFont
                        font = ImageFont.load_default()
                    except Exception:
                        font = None

                    for row_idx, row in enumerate(positions):
                        for ch, cx in row:
                            abs_x = paste_x + cx
                            abs_y0 = paste_y + row_idx * (TILE_HEIGHT + LINE_SPACING)
                            abs_y1 = abs_y0 + TILE_HEIGHT
                            # offset copy in blue (draw first)
                            abs_x2 = abs_x + 1
                            abs_y0_2 = abs_y0 + 1
                            draw.line([(abs_x2, abs_y0_2), (abs_x2, abs_y0_2 + TILE_HEIGHT)], fill=(0, 0, 255, 128))
                            draw.text((abs_x2 + 1, abs_y0_2 - 10), str(abs_x2), fill=(0, 0, 255, 255), font=font)
                            # original in red (draw on top)
                            draw.line([(abs_x, abs_y0), (abs_x, abs_y1)], fill=(255, 0, 0, 128))
                            draw.text((abs_x + 1, abs_y0 - 10), str(abs_x), fill=(255, 0, 0, 255), font=font)

                    # annotate character rect and name
                    if char_img:
                        draw.rectangle([char_x, char_y, char_x + char_img.width, char_y + char_img.height], outline=(255, 128, 0, 255))
                        draw.text((char_x, char_y - 10), str(speaker), fill=(255, 128, 0, 255), font=font)

                    # write positions to a debug text file (include both original and offset)
                    dbg_txt = os.path.join(out_dir, f"{counter}.debug.txt")
                    with open(dbg_txt, 'w', encoding='utf-8') as df:
                        for row_idx, row in enumerate(positions):
                            for ch, cx in row:
                                df.write(f"line{row_idx}\tch:{ch}\torig_x:{paste_x + cx}\toffset_x:{paste_x + cx + 1}\n")
                        if char_img:
                            df.write(f"char:{speaker}\tchar_x:{char_x}\tchar_y:{char_y}\n")

                    # save a debug overlay image as well
                    dbg_img_path = os.path.join(out_dir, f"{counter}_dbg.png")
                    out_img.save(dbg_img_path)

            else:
                # No background - create a canvas large enough to hold text copies and optional character image
                char_img = None
                char_x, char_y = 58, 160
                if speaker:
                    for cand in [f"{speaker}.png", f"{speaker.lower()}.png", f"{speaker.capitalize()}.png"]:
                        p = os.path.join(tiles_dir, cand)
                        if os.path.isfile(p):
                            try:
                                char_img = Image.open(p).convert('RGBA')
                                break
                            except Exception:
                                continue

                # Determine main_y relative to canvas: 0 for '3' speakers, 13px down for others
                main_y = 0 if has_suffix_3 else 13
                shadow_offset = (1, 1)

                new_w = max(text_img.width + shadow_offset[0], (char_x + char_img.width + 1) if char_img else 0)
                new_h = max(main_y + text_img.height + shadow_offset[1], (char_y + char_img.height + 1) if char_img else 0)
                # ensure at least 1x1
                new_w = max(1, new_w)
                new_h = max(1, new_h)

                canvas = Image.new('RGBA', (new_w, new_h), (0, 0, 0, 0))
                # Paste character (behind), then shadow copy, then main
                if char_img:
                    canvas.paste(char_img, (char_x, char_y), char_img)
                # shadow
                canvas.paste(shadow_img, (shadow_offset[0], main_y + shadow_offset[1]), shadow_img)
                # main
                canvas.paste(main_img, (0, main_y), main_img)
                out_img = canvas

                if debug:
                    # annotate both copies (offset first, then original)
                    draw = ImageDraw.Draw(out_img)
                    try:
                        from PIL import ImageFont
                        font = ImageFont.load_default()
                    except Exception:
                        font = None
                    for row_idx, row in enumerate(positions):
                        for ch, cx in row:
                            abs_x = cx
                            abs_y0 = row_idx * (TILE_HEIGHT + LINE_SPACING)
                            abs_y1 = abs_y0 + TILE_HEIGHT
                            # offset copy in blue (draw first)
                            abs_x2 = abs_x + 1
                            abs_y0_2 = abs_y0 + 1
                            draw.line([(abs_x2, abs_y0_2), (abs_x2, abs_y0_2 + TILE_HEIGHT)], fill=(0, 0, 255, 128))
                            draw.text((abs_x2 + 1, abs_y0_2 - 10), str(abs_x2), fill=(0, 0, 255, 255), font=font)
                            # original in red (draw on top)
                            draw.line([(abs_x, abs_y0), (abs_x, abs_y1)], fill=(255, 0, 0, 128))
                            draw.text((abs_x + 1, abs_y0 - 10), str(abs_x), fill=(255, 0, 0, 255), font=font)

                    if char_img:
                        draw.rectangle([char_x, char_y, char_x + char_img.width, char_y + char_img.height], outline=(255, 128, 0, 255))
                        draw.text((char_x, char_y - 10), str(speaker), fill=(255, 128, 0, 255), font=font)

                    dbg_txt = os.path.join(out_dir, f"{counter}.debug.txt")
                    with open(dbg_txt, 'w', encoding='utf-8') as df:
                        for row_idx, row in enumerate(positions):
                            for ch, cx in row:
                                df.write(f"line{row_idx}\tch:{ch}\torig_x:{cx}\toffset_x:{cx + 1}\n")
                        if char_img:
                            df.write(f"char:{speaker}\tchar_x:{char_x}\tchar_y:{char_y}\n")
                    dbg_img_path = os.path.join(out_dir, f"{counter}_dbg.png")
                    out_img.save(dbg_img_path)

            out_name = f"{counter}.png"
            out_path = os.path.join(out_dir, out_name)
            out_img.save(out_path)

            # Create a 2x scaled version in a sibling 'output2x' directory
            out2_dir = os.path.join(os.path.dirname(out_dir), 'output2x')
            os.makedirs(out2_dir, exist_ok=True)
            scaled = out_img.resize((max(1, out_img.width * 2), max(1, out_img.height * 2)), Image.NEAREST)
            out2_path = os.path.join(out2_dir, out_name)
            scaled.save(out2_path)

            # If debug overlay PNG exists, scale and copy it too
            dbg_png_src = os.path.join(out_dir, f"{counter}_dbg.png")
            dbg_txt_src = os.path.join(out_dir, f"{counter}.debug.txt")
            if os.path.isfile(dbg_png_src):
                try:
                    dbg_img = Image.open(dbg_png_src)
                    dbg_scaled = dbg_img.resize((max(1, dbg_img.width * 2), max(1, dbg_img.height * 2)), Image.NEAREST)
                    dbg_out2 = os.path.join(out2_dir, f"{counter}_dbg.png")
                    dbg_scaled.save(dbg_out2)
                except Exception:
                    pass
            # Copy debug text if present
            if os.path.isfile(dbg_txt_src):
                try:
                    shutil.copyfile(dbg_txt_src, os.path.join(out2_dir, f"{counter}.debug.txt"))
                except Exception:
                    pass

            num_lines = len(lines)
            short_content = content[:50] + '...' if len(content) > 50 else content
            index_lines.append(f"{counter}.png\tline:{file_line_no}\tlines:{num_lines}\t{content}")
            print(f"Wrote {out_path} ({num_lines} lines) for input line {file_line_no}: '{short_content}'")
            counter += 1

    # Write index file
    idx_path = os.path.join(out_dir, 'index.txt')
    with open(idx_path, 'w', encoding='utf-8') as idxf:
        idxf.write('\n'.join(index_lines))
    print(f"Index written to {idx_path}")


def main():
    parser = argparse.ArgumentParser(description='Generate preview images for communication messages from SG/GAMEMSGS.INC. Single-purpose vibe slop utility for layout/spacing.')
    parser.add_argument('input', help='Input message include file (eg. SG/GAMEMSGS.INC)')
    parser.add_argument('--out', default=None, help='Directory to write numbered PNGs (default: output in script dir)')
    parser.add_argument('--debug', action='store_true', help='Write per-character position logs and a debug overlay image')
    args = parser.parse_args()

    if not os.path.isfile(args.input):
        print(f"Input file not found: {args.input}")
        sys.exit(1)

    # Auto-detect tiles directory
    tiles_dir = find_tiles_dir()
    if tiles_dir:
        print(f"Using tiles directory: {tiles_dir}")
    else:
        print("ERROR: No tile folder found. Please ensure 'img' folder exists with tile PNGs.")
        sys.exit(1)

    # Output directory
    out_dir = args.out if args.out else os.path.join(os.path.dirname(os.path.abspath(__file__)), 'output')

    process_file(args.input, tiles_dir, out_dir, args.debug)


if __name__ == '__main__':
    main()


if __name__ == '__main__':
    main()
