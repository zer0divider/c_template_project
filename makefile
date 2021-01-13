# sources
SRC_DIR=src
SRC=main.c
SRC_FILE_ENDING=c

# output executable
BIN=program

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
	./$<

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
	@echo "GCC $<"
	$(Q)$(CC) -MT $@ $(DEPFLAGS) -MF $(BUILD_DIR)/$*.d -c $< $(CFLAGS) -o $@

# pull in dependencies from .cpp files
-include $(DEP)

# generating ctags
ctags:
	ctags -R $(CTAGS_DIRS) $(CTAGS_FLAGS)

# clear all
clean:
	rm -rf $(BIN) $(BUILD_DIR)

# define phony targets
.PHONY: all run clean debug ctags
