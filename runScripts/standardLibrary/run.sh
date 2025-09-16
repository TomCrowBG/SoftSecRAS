#!/bin/bash
SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
GEM5_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")"/../../gem5 && pwd)"
cd "$SCRIPT_DIR" || exit 1

# Change out this script file name
SCRIPT_NAME="standardLibrary.py"

"$GEM5_DIR"/build/ALL/gem5.opt "$SCRIPT_NAME"