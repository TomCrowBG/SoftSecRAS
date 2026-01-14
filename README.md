# SoftSecRAS
Hardware protected return address stack to protect against ROP attacks simulated in gem5

Tom Maxellon 2025

## About this project

TODO

### Motivation

TODO

### Methods

TODO

### Conclusion

TODO

## Todo list

### Return Address Stack

[ ] Add memory area <br />
[ ] Set page table permission flags <br />
[ ] Parametrize (optional)

### Custom MMU

[ ] Create class <br />
[ ] Add debug info <br />
[ ] Add Instruction flags <br />
[ ] Make decoder forward flags <br />
[ ] Let RAS flag bypass page table permission

### Rewrite CALL/RET

[ ] Locate CALL/RET inside of gem5's decoder <br />
[ ] Add RAS register <br />
[ ] Implement RAS logic into CALL/RET <br />
[ ] RAS register bounds <br />
[ ] RAS register out of bounds fault

### Evaluation

[ ] Find available Shadow Stack implementation <br />
[ ] Setup binaries <br />
[ ] Evaluate Security on ROP attacks <br />
[ ] Setup SPEC benchmark <br />
[ ] Evaluate Performance differences

## How to work on this repository
Run 'git submodule update --init' to obtain all submodules (gem5)

As a note, this repository uses a fork of gem5 that was specifically made for this project.

### Building gem5
Dependencies for building gem5:
- git
- gcc/clang (compiler)
- scons (build environment)
- python 3.6+
- optional: protobuf, boost

For Ubuntu:

```bash
sudo apt install build-essential scons python3-dev git pre-commit zlib1g zlib1g-dev \
	libprotobuf-dev protobuf-compiler libprotoc-dev libgoogle-perftools-dev \
	libboost-all-dev  libhdf5-serial-dev python3-pydot python3-venv python3-tk mypy \
	m4 libcapstone-dev libpng-dev libelf-dev pkg-config wget cmake doxygen clang-format
```

Then build gem5 by running this command inside of the gem5 directory:
`scons build/ALL/gem5.opt -j{#cores}`
In this case, "ALL" refers to the build target you're using.
You can add your own build targets inside of `./gem5/build_opts/`.

### Running gem5

If you now want to run a script, use:
`./gem5/build/ALL/gem5.opt ./runScripts/[file]`

If you want to recreate a workspace within vscode to develop for gem5, add these files:

For python environment variables - `.env`:

```markdown
PYTHONPATH=${workplaceFolder}/gem5/src/python:$PYTHONPATH
```

For vscode settings - `.vscode/settings.json`:

```markdown
{
    "python.analysis.extraPaths": ["${workspaceFolder}/gem5/src/python"],	// For autocomplete
    "python.envFile": "${workspaceFolder}/.env"								// For environment variables
}
```

To see if it works, open up a script within `./runScripts/` and see if the imports get recognized by the editor, and then run the scripts, e.g. `./gem5/build/ALL/gem5.opt ./runScripts/runLinux/runLinux.py`.

Serial Outputs of the script will be placed under `m5out/board.pc.com_1.device` located in the directory you ran the script in.
It is therefore recomended to run all scripts within their designated folder when using `gem5.opt` directly in the console.

### Run script templates

To have a clean and replicatable setup to load resources, manage binaries and manage paths without needing to implement all the necessarry overhead, all scripts are placed in their own directory under `./runScripts/`.

This also allows you to run your `run.sh` script from anywhere inside of this repository.

To add a new script, clone the `runScripts/templateScript` directory and change the `SCRIPT_NAME` variable to your scripts file name. Remember to add execute file permissions by running `chmod -R u+x ./runScripts/[YourDirectory]`.