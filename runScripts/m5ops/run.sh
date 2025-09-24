#!/bin/bash
SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
GEM5_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")"/../../gem5 && pwd)"
cd "$SCRIPT_DIR" || exit 1


# Change out this script file name
SCRIPT_NAME="m5ops.py"
BINARY_NAME="m5ops"


# Generate build environment
sed "s|__GEM5__PATH__|$GEM5_DIR|g" \
    "$SCRIPT_DIR/Makefile_template" \
    > "$SCRIPT_DIR/Makefile"


# Build resources
make clean
make all


# Calculate Hash
MD5SUM_HASH=$(md5sum "$BINARY_NAME")


# Generate gem5 configurations
sed "s|__BINARY_PATH__|$SCRIPT_DIR|g" \
    "$SCRIPT_DIR/gem5_config_template.json" \
    > "$SCRIPT_DIR/gem5_config.json"

sed "s|__BINARY_PATH__|$SCRIPT_DIR|g" \
    "$SCRIPT_DIR/local_resources_template.json" | \
sed "s|__MD5SUM__|$MD5SUM_HASH|g" \
    > "$SCRIPT_DIR/local_resources.json"


# Local resource path
export GEM5_CONFIG=$SCRIPT_DIR/gem5_config.json


# Run gem5
"$GEM5_DIR"/build/ALL/gem5.opt -re "$SCRIPT_NAME"