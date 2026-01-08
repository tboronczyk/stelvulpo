#!/bin/bash
#
# Decrunch all CCR files in SG/DATA to BIN format
# Usage: ./decrunch_ccr.sh [data_path]
# Example: ./decrunch_ccr.sh ../SG/DATA
#

# Default data path
DATA_PATH="${1:-.\/SG\/DATA}"

# Get the directory where this script is located
SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
DECRUNCH_EXE="$SCRIPT_DIR/sf_decrunch"
REPO_ROOT="$(dirname "$SCRIPT_DIR")"

# Convert relative path to absolute if needed
if [[ ! "$DATA_PATH" = /* ]]; then
    DATA_PATH="$REPO_ROOT/$DATA_PATH"
fi

# Check if data directory exists
if [ ! -d "$DATA_PATH" ]; then
    echo "Error: Data directory not found: $DATA_PATH"
    exit 1
fi

# Check if decrunch tool exists
if [ ! -f "$DECRUNCH_EXE" ]; then
    echo "Error: Decrunch tool not found: $DECRUNCH_EXE"
    exit 1
fi

echo "Data directory: $DATA_PATH"
echo "Decrunch tool: $DECRUNCH_EXE"
echo ""

# Count files
ccr_count=$(find "$DATA_PATH" -maxdepth 1 -iname "*.CCR" | wc -l)

if [ $ccr_count -eq 0 ]; then
    echo "No CCR files found in $DATA_PATH"
    exit 0
fi

echo "Found $ccr_count CCR file(s)"
echo ""

success_count=0
fail_count=0

# Process each CCR file
for ccr_file in $(find "$DATA_PATH" -maxdepth 1 -iname "*.CCR" | sort); do
    basename=$(basename "$ccr_file" .CCR)
    input_path="$ccr_file"
    output_path="$DATA_PATH/$basename.BIN"
    
    printf "Decrunching: $(basename "$ccr_file") -> $basename.BIN ... "
    
    if "$DECRUNCH_EXE" "$input_path" "$output_path" >/dev/null 2>&1; then
        echo "OK"
        ((success_count++))
    else
        echo "FAILED"
        ((fail_count++))
    fi
done

echo ""
echo "Complete: $success_count successful, $fail_count failed"
