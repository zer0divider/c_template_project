# source directory
SRC_DIR=src

# add your source files here:
SRC=main.c

# file ending of source files
SRC_FILE_ENDING=c

# output executable
BIN=program

# includes
INCLUDE=-I/usr/include

# libraries
LIBS=-lm

# build directory
BUILD_DIR=build

# compiler
CC=gcc

# debugger
GDB=gdb

# cflags
CFLAGS=-std=c11 -g

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
	@echo "EXECUTING '$(BIN)':\n"
	$(Q)./$<

# start debugging
debug: $(BIN)
	$(GDB) ./$<

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
