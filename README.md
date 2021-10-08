# C Template Project
This is a default C/C++ project that can be built with GNU Make.

# Targets
There are a few default make targets:
- ```make all```: builds the main executable
- ```make run```: builds and runs main executable
- ```make debug```: builds and runs main executable in GDB (Debug c-flag ```-g``` has to be set)
- ```make clean```: removes build directory and main executable

In the file ```args.txt``` you can specify additional commandline arguments passed to the main executable on launch for targets ```run``` and ```debug```.

