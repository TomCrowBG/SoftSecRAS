# SoftSecRAS
Hardware protected return address stack to protect against ROP attacks simulated in gem5
Tom Maxellon 2025

## Preparations
Run 'git submodule update --init' to obtain all submodules (gem5)

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
`scons build/ALL/gem5.opt`

### Running gem5

If you now want to run a script, use:
`./gem5/build/ALL/gem5.opt ./runScripts/[file]`

If you want to recreate a workspace within vscode to develop for gem5, add these files:

.env file for python environment variables:

```markdown
PYTHONPATH=${workplaceFolder}/gem5/src/python:$PYTHONPATH
```

.vscode/settings.json file for vscode settings:

```markdown
{
    "python.analysis.extraPaths": ["${workspaceFolder}/gem5/src/python"],	// For autocomplete
    "python.envFile": "${workspaceFolder}/.env"								// For environment variables
}
```

To see if it works, open up a script within `./runScripts/` and see if the imports get recognized by the editor, and then run the scripts, e.g. `./runScripts/runLinux/run.sh` or `./gem5/build/ALL/gem5.opt ./runScripts/runLinux/runLinux.py`.

Serial Outputs of the script will be placed under `m5out/board.pc.com_1.device` located in the directory you ran the script in.
It is therefore recomended to run all scripts within their designated folder.

### Develop with gem5

To add a new script, clone the `runScripts/templateScript` directory and change the `SCRIPT_NAME` variable to your scripts file name. Remember to add execute file permissions by running `chmod -R u+x ./runScripts/[YourDirectory]`.

If running `/runScripts/[YourDirectory]/run.sh` prints:

```bash
gem5 Simulator System.  https://www.gem5.org [...]
```

you're good to go.