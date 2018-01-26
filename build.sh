#! /bin/sh

set -e

ATLAS="../Atlas/Atlas.exe"
ENCODE="../Star Fox 2 Font Tools/sf2_encode.exe"

if [ "$#" -ne 1 ]; then
    echo "usage: $(basename "$0") ROM" 1>&2
    exit
fi
ROM="$1"

echo -e "\nUpdating title screen..."
## logo
dd if=asm/blank.bin of="$ROM" conv=notrunc bs=1 seek=759464 count=1072
dd if=asm/blank.bin of="$ROM" conv=notrunc bs=1 seek=760536 count=352
"$ENCODE" gfx/0B9AD8.bin "$ROM" B9AD8
"$ENCODE" gfx/0B9C38.bin "$ROM" B9C38
## press start
dd if=asm/blank.bin of="$ROM" conv=notrunc bs=1 seek=753664 count=608
dd if=asm/blank.bin of="$ROM" conv=notrunc bs=1 seek=763492 count=4416
"$ENCODE" gfx/0B8260.bin "$ROM" B8260
"$ENCODE" gfx/0BB7A4.bin "$ROM" BB7A4

echo -e "\nUpdating controller setup..."
## config select
dd if=asm/blank.bin of="$ROM" conv=notrunc bs=1 seek=755945 count=2832
dd if=asm/blank.bin of="$ROM" conv=notrunc bs=1 seek=758780 count=684
"$ENCODE" gfx/0B93FC.bin "$ROM" B93FC
"$ENCODE" gfx/0B96A8.bin "$ROM" B96A8
## training/game select
dd if=asm/blank.bin of="$ROM" conv=notrunc bs=1 seek=1030117 count=436
"$ENCODE" gfx/0FB999.bin "$ROM" FB999

echo -e "\nUpdating level map..."
dd if=asm/blank.bin of="$ROM" conv=notrunc bs=1 seek=708236 count=2612
dd if=asm/blank.bin of="$ROM" conv=notrunc bs=1 seek=733264 count=740
"$ENCODE" gfx/0AD8C0.bin "$ROM" AD8C0
"$ENCODE" gfx/0B3334.bin "$ROM" B3334

echo -e "\nUpdating in-game graphics..."
# scramble/stage
#...
# hud 
dd if=asm/blank.bin of="$ROM" conv=notrunc bs=1 seek=678926 count=1264
"$ENCODE" gfx/0A60FE.bin "$ROM" A60FE

echo -e "\nUpdating text..."
dd if=/dev/zero of="$ROM" conv=notrunc bs=1 seek=59286 count=170
dd if=/dev/zero of="$ROM" conv=notrunc bs=1 seek=59457 count=5016
"$ATLAS" "$ROM" scripts/sf-dialog.txt
dd if=/dev/zero of="$ROM" conv=notrunc bs=1 seek=1043823 count=1642
"$ATLAS" "$ROM" scripts/sf-enemies.txt

echo -e "\nUpdating fonts..."
#in-game font
dd if=gfx/00D996.bin of="$ROM" conv=notrunc bs=1 seek=55702 
## credits font
dd if=gfx/0A3EDA.bin of="$ROM" conv=notrunc bs=1 seek=671450
## enemy details font
dd if=asm/blank.bin of="$ROM" conv=notrunc bs=1 seek=680190 count=372
"$ENCODE" gfx/0A6272.bin "$ROM" A6272

echo -e "\nUpdating continue..."
dd if=asm/blank.bin of="$ROM" conv=notrunc bs=1 seek=681022 count=3664
dd if=asm/blank.bin of="$ROM" conv=notrunc bs=1 seek=684686 count=456
"$ENCODE" gfx/0A728E.bin "$ROM" A728E
"$ENCODE" gfx/0A7456.bin "$ROM" A7456

echo -e "\nUpdating sound files..."
#...

echo -e "\nUpdating credits..."
#...
dd if=/dev/zero of="$ROM" conv=notrunc bs=1 seek=674010 count=758
dd if=/dev/zero of="$ROM" conv=notrunc bs=1 seek=675300 count=32
"$ATLAS" "$ROM" scripts/sf-credits.txt

echo -e "\nUpdating rom header..."
#...
