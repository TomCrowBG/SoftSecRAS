#!/bin/bash
SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
GEM5_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")"/../../gem5 && pwd)"
cd "$SCRIPT_DIR" || exit 1

# Change out this script file name
SCRIPT_NAME="mmu-test.py"

sed "s|__BINARY_PATH__|$SCRIPT_DIR|g" \
    "$SCRIPT_DIR/gem5_config_template.json" \
    > "$SCRIPT_DIR/gem5_config.json"

sed "s|__BINARY_PATH__|$SCRIPT_DIR|g" \
    "$SCRIPT_DIR/local_resources_template.json" \
    > "$SCRIPT_DIR/local_resources.json"

# Local resource path
export GEM5_CONFIG=$SCRIPT_DIR/gem5_config.json

# Build resources
gcc -o pattern pattern.c

# Run gem5
"$GEM5_DIR"/build/X86_RAS/gem5.opt "$SCRIPT_NAME"