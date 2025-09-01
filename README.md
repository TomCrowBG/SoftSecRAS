# SoftSecRAS
Hardware protected return address stack to protect against ROP attacks simulated in gem5

## preparations
run 'git submodule update --init' to obtain all submodules (gem5)

### building gem5
dependencies for building gem5:
- git
- gcc/clang (compiler)
- scons (build environment)
- python 3.6+
- optional: protobuf, boost

for ubuntu:
'sudo apt install build-essential scons python3-dev git pre-commit zlib1g zlib1g-dev \
	libprotobuf-dev protobuf-compiler libprotoc-dev libgoogle-perftools-dev \
	libboost-all-dev  libhdf5-serial-dev python3-pydot python3-venv python3-tk mypy \
	m4 libcapstone-dev libpng-dev libelf-dev pkg-config wget cmake doxygen clang-format'

then build gem5 by running:
'scons build/ALL/gem5.opt'

## TODO

Tom Maxellon 2025
