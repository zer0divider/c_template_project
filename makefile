# source directory
SRC_DIR=src

# add your source files here:
SRC=main.c
#SRC=main.cpp

# file ending of source files
SRC_FILE_ENDING=c
#SRC_FILE_ENDING=cpp

# output executable
BIN=program

# cflags
CFLAGS=-std=c11 -g
#CFLAGS=-std=c++11 -g

# includes
INCLUDE=
INCLUDE_PATHS_FILE=config/include_paths.txt
ifneq ("$(wildcard $(INCLUDE_PATHS_FILE))", "")
	INCLUDE += $(shell cat $(INCLUDE_PATHS_FILE))
endif

# libraries
LIBS = -lm

# library paths
LIB_PATHS_FILE=config/lib_paths.txt
ifneq ("$(wildcard $(LIB_PATHS_FILE))", "")
	LIBS += $(shell cat $(LIB_PATHS_FILE))
endif

# build directory
BUILD_DIR=build

# compiler
CC=gcc
#CC=g++

# debugger
GDB=gdb

# commandline arguments
PROGRAM_ARGS_FILE=config/args.txt
ifneq ("$(wildcard $(PROGRAM_ARGS_FILE))", "")
	PROGRAM_ARGS=$(shell cat $(PROGRAM_ARGS_FILE))
endif

# dependency flags
DEPFLAGS=-MMD -MP 

# tag generation
CTAGS_DIRS=./$(SRC_DIR)
CTAGS_FLAGS=--c-kinds=+p

# object files
OBJ=$(SRC:%.$(SRC_FILE_ENDING)=$(BUILD_DIR)/%.o)

# dependency files
DEP=$(SRC:%.$(SRC_FILE_ENDING)=$(BUILD_DIR)/%.d)

# verbose variable
VERBOSE?=0
ifeq ($(VERBOSE), 0)
	Q := @
endif

# default target build all
all: $(BIN)

# run application
run: $(BIN)
	./$< $(PROGRAM_ARGS)

# start debugging
debug: $(BIN)
	$(GDB) --args ./$< $(PROGRAM_ARGS) 

# create build directory
$(BUILD_DIR):
	@echo "MKDIR $(BUILD_DIR)"
	$(Q)mkdir -p $@

# link executable
$(BIN): $(OBJ)
	@echo "LINKING $(BIN)"
	$(Q)$(CC) $^ $(LIBS) $(CFLAGS) $(LINKER) -o $@

# compile with dep flags
$(BUILD_DIR)/%.o: $(SRC_DIR)/%.$(SRC_FILE_ENDING) | $(BUILD_DIR)
	@echo "CC $<"
	$(Q)$(CC) -MT $@ $(DEPFLAGS) -MF $(BUILD_DIR)/$*.d $(INCLUDE) -c $< $(CFLAGS) -o $@

# pull in dependencies from .cpp files
-include $(DEP)

# generating ctags
ctags:
	ctags $(CTAGS_FLAGS) -R $(CTAGS_DIRS) 

# clear all
clean:
	@echo "CLEANING UP."
	$(Q)rm -rf $(BIN) $(BUILD_DIR)

# define phony targets
.PHONY: all run clean debug ctags
