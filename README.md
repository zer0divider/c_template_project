# C Template Project
This is a default C/C++ project that can be built with GNU Make.

# Targets
There are a few default make targets:
- ```make all```: builds the main executable
- ```make run```: builds and runs main executable
- ```make debug```: builds and runs main executable in GDB (Debug c-flag ```-g``` has to be set)
- ```make clean```: removes build directory and main executable

# Libraries
Add the required libraries for your project to the ```PKG_LIBS``` variable in the makefile.

# User defined arguments
In the file ```config/args.txt``` you can specify additional commandline arguments passed to the main executable on launch for targets ```run``` and ```debug```.
The files ```config/lib_paths.txt``` and ```config/include_paths.txt``` contain system specific paths for required libraries and headers.
Note that the actual linking libraries e.g. ```-lm``` must be specified in the makefile.
