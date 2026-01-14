#!/bin/bash
SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
GEM5_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")"/../../gem5 && pwd)"
cd "$SCRIPT_DIR" || exit 1

# Change out this script file name
SCRIPT_NAME="riscv-add16.py"

sed "s|__BINARY_PATH__|$SCRIPT_DIR|g" \
    "$SCRIPT_DIR/gem5_config_template.json" \
    > "$SCRIPT_DIR/gem5_config.json"

sed "s|__BINARY_PATH__|$SCRIPT_DIR|g" \
    "$SCRIPT_DIR/local_resources_template.json" \
    > "$SCRIPT_DIR/local_resources.json"

# Local resource path
export GEM5_CONFIG=$SCRIPT_DIR/gem5_config.json

# Build resources
# This needs a riscv cross compiler to be installed and added to $Path
# See https://github.com/riscv-collab/riscv-gnu-toolchain
#riscv64-unknown-elf-gcc -static --specs=rdimon.specs -lrdimon -o riscv-add16-demo riscv-add16-demo.c

# If it doesn't work, use the provided precompiled add16_test binary instead

# Run gem5
"$GEM5_DIR"/build/ALL/gem5.opt "$SCRIPT_NAME"