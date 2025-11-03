GEM5_PATH = /home/tomcrow/Repos/SoftSecRAS/gem5
ISA = x86
GXX = g++


all: m5ops

m5ops: main.cpp
	$(GXX) -o m5ops main.cpp \
	-I$(GEM5_PATH)/include \
	-L$(GEM5_PATH)/util/m5/build/$(ISA)/out \
	-lm5

clean:
	rm -f m5ops