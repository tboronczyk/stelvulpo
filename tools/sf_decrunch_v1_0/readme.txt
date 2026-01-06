+------------------------------------------------------------------------------+

                        +------------------------------+
                        |   sf_crunch / sf_decrunch    |
                        | Star Fox Compression Utility |
                        +------------------------------+

+------------------------------------------------------------------------------+

sf_crunch and sf_decrunch are compression and decompression utilities for the
graphics data in Star Fox and Star Fox 2. This format was used for most of the
background and sprite graphics, as well as the tilemaps (also known as
"name tables"). It does not apply to any of the 3D graphics in the game.
Star Fox and Star Fox 2 both use the same format, which is a variant of LZW
compression.

I was motivated to make this utility after the source code became available via
the recent Nintendo source code leak. This utility obviously doesn't contain
any of the leaked code, but I did use the decompression source code to help
reverse engineer the format. The decompression subroutine in the ROM runs on
the Super FX chip, and its source code is in a file called MDECRU.MC which was
apparently written by Krister Wombell. I liked the name "decrunch" that Krister
used, so I used it for this utility.

The compressed graphics data was also included in the leak. The files have
extension .CCR (compressed graphics) and .PCR (compressed tilemap/name table
data). The filenames from the source code are listed below along with their
location in the U.S. version of the Star Fox ROM.

This compression format is unique in that control sequences are stored _after_
the data sequences that they correspond to, so the decompressor must parse the
data backwards, starting at the end of the compressed stream and progressing to
the beginning.

Because of this quirk, I added a command-line option for the decompressor to
specify the offset of the _end_ of a compressed data segment in a file. The
offsets of the compressed data segments in the U.S. version of the Star Fox ROM
are listed below. I didn't include an option to specify an offset for the
compressor because it would ostensibly be used to compress an entire file.

The only other utility that I'm aware of which supports this format is FuSoYa's
Lunar Compress library, but since it is closed source and only for Windows, I
wanted to make an open source utility that could be compiled on a computer
running any operating system.

With that in mind, this archive does not contain any executable files. It only
contains the C++ source files for the compressor (sf_crunch.cpp) and
decompressor (sf_decrunch.cpp). They are very simple programs, so they should
be easy to compile with any C++ compiler. You are also free to use and modify
this code if you would like to use it in your own work. I've tested both
programs pretty thoroughly, but please let me know if you find any problems.

- everything8215 (everything8215@gmail.com)

+------------------------------------------------------------------------------+

Revisions:

v1.0 (7/31/2020): Initial release

+------------------------------------------------------------------------------+

This is a list of compressed data segments in v1.2 of the U.S. Star Fox ROM
(CRC32: 0x8FC4E6D0). All offsets are for a headerless ROM. For a headered ROM,
add 0x200. Files with .CCR extension are graphics in SNES native interleaved
format (mostly 4bpp, some are 2bpp as noted). Files with .PCR extension are
tilemaps (i.e. name tables), in the 16-bit SNES format.

ROM Location*    LoROM Location             Source Filename (Description)
-------------    --------------       ------------------------------------------

02F691-02FECD    05F691-05FECD        AND.CCR (Andross, Game Over Screen)
06F99D-06FBB9    0DF99D-0DFBB9        T-ST.CCR
0771CE-077C62    0EF1CE-0EFC62        M.PCR
08F679-08FB89    11F679-11FB89        DOG.CCR (Pepper)
0A4E26-0A55AA    14CE26-14D5AA        DEMO.CCR (Corneria Planet)
0A55AA-0A5896    14D5AA-14D896        DEMO.PCR
0A5896-0A5B5E    14D896-14DB5E        HOLE-A.CCR
0A5B5E-0A5B6E    14DB5E-14DB6E        B.CCR
0A5B6E-0A5C0E    14DB6E-14DC0E        B.PCR
0A5C0E-0A60FE    14DC0E-14E0FE        OBJ-1.CCR
0A60FE-0A6272    14E0FE-14E272        E-TEST.CCR
0A6272-0A62C2    14E272-14E2C2        E-TEST.PCR
0A62C2-0A6362    14E2C2-14E362        E-TEST2.CCR
0A6362-0A643E    14E362-14E43E        E-TEST2.PCR
0A643E-0A728E    14E43E-14F28E        FOX.CCR (Fox, Continue Screen)
0A728E-0A7456    14F28E-14F456        FOX.PCR
0A7456-0A75B2    14F456-14F5B2        B-M.CCR
0A75B2-0A7ECE    14F5B2-14FECE        ST-P.CCR (Corneria Background)
0A7ECE-0A7FA6    14FECE-14FFA6        2-3H.PCR
0A8000-0A81E4    158000-1581E4        ST-P.PCR
0A81E4-0A8C50    1581E4-158C50        2-2.CCR (Sector X Background)
0A8C50-0A9B48    158C50-159B48        2-3.CCR (Titania Background)
0A9B48-0A9C38    159B48-159C38        2-3B.CCR (Titania Background, 2bpp)
0A9C38-0AA408    159C38-15A408        STARS.CCR
0AA408-0AA6B0    15A408-15A6B0        1-3-B.CCR
0AA6B0-0AAF04    15A6B0-15AF04        SPACE.CCR
0AAF04-0ABC14    15AF04-15BC14        LAST.PCR
0ABC14-0AC964    15BC14-15C964        3-2.CCR (Fortuna Planet, from Asteroid)
0AC964-0ACE8C    15C964-15CE8C        FS-BG3.CCR (Venom 2 Background, 2bpp)
0ACE8C-0AD8C0    15CE8C-15D8C0        MAP.CCR (Map Background)
0AD8C0-0AE898    15D8C0-15E898        3-3.CCR (Fortuna Background)
0AE898-0AEB10    15E898-15EB10        FS-NI.PCR
0AEB10-0AEF34    15EB10-15EF34        T-SS.PCR
0AEF34-0AFF1C    15EF34-15FF1C        3-4.CCR (Macbeth Planet, from Sector Z)
0B0000-0B03C8    168000-1683C8        2-2.PCR
0B03C8-0B1150    1683C8-169150        LSB.CCR (Venom 1 Background)
0B1150-0B2014    169150-16A014        F-1.CCR (Venom 2 Background)
0B2014-0B2648    16A014-16A648        B-HOLE.CCR (Black Hole Background)
0B2648-0B2A20    16A648-16AA20        T-F-S.PCR
0B2A20-0B2C44    16AA20-16AC44        2-3.PCR
0B2C44-0B3050    16AC44-16B050        2-3B.PCR
0B3050-0B3334    16B050-16B334        MAP.PCR
0B3334-0B3944    16B334-16B944        STARS.PCR
0B3EF8-0B41B8    16BEF8-16C1B8        1-3-B.PCR
0B41B8-0B45AC    16C1B8-16C5AC        1-3.PCR
0B45AC-0B4AF4    16C5AC-16CAF4        1-4.PCR
0B4AF4-0B513C    16CAF4-16D13C        1-4.CCR (Battle Base Meteor Background)
0B513C-0B5360    16D13C-16D360        3-3.PCR
0B5360-0B571C    16D360-16D71C        3-4.PCR
0B571C-0B59F4    16D71C-16D9F4        LSB.PCR
0B59F4-0B6024    16D9F4-16E024        F-OBJ.CCR
0B6024-0B6D34    16E024-16ED34        B-HOLE.PCR
0B6D34-0B6E24    16ED34-16EE24        HOLE-A.PCR
0B6E24-0B7344    16EE24-16F344        T-SP.PCR
0B7344-0B7A8C    16F344-16FA8C        2-4.PCR
0B7A8C-0B7F94    16FA8C-16FF94        T-ST.PCR
0B8000-0B8260    178000-178260        CP.PCR
0B8260-0B849C    178260-17849C        T-SP.CCR
0B849C-0B8718    17849C-178718        DOG.PCR
0B8718-0B88EC    178718-1788EC        C-M.CCR
0B88EC-0B93FC    1788EC-1793FC        CONT-2.CCR (Controller Setup)
0B93FC-0B96A8    1793FC-1796A8        CONT-2.PCR
0B96A8-0B9AD8    1796A8-179AD8        TI-3-US.CCR (Game Title, 2bpp)
0B9AD8-0B9C38    179AD8-179C38        TI-3-US.PCR
0B9C38-0BA664    179C38-17A664        2-4.CCR
0BA664-0BB7A4    17A664-17B7A4        CP.CCR (Title Screen)
0BF0D0-0BFDCC    17F0D0-17FDCC        M.CCR (Out of This Dimension)
0FB7E5-0FB999    1FB7E5-1FB999        OBJ-3.CCR
0FF5CB-0FF963    1FF5CB-1FF963        F-1.PCR

* Note: To decompress a segment with the ROM file as the input, you must
  specify the _end_ address given above (not the start address) as the second
  command line argument.
  
+------------------------------------------------------------------------------+
  
This program is free software: you can redistribute it and/or modify
it under the terms of the GNU General Public License as published by
the Free Software Foundation, either version 3 of the License, or
(at your option) any later version.

This program is distributed in the hope that it will be useful,
but WITHOUT ANY WARRANTY; without even the implied warranty of
MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
GNU General Public License for more details.

You should have received a copy of the GNU General Public License
along with this program.  If not, see <https://www.gnu.org/licenses/>.

+------------------------------------------------------------------------------+
