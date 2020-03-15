###############################################################################
#
# Makefile for compiling STM32F1xx devices, specially, STM32F103C8T6 or bluepill
# Copyright (C) 2020 Alexandre Amory <amamory@gmail.com>
#
###############################################################################
# RELEVANT VARIABLES:
#
# In the TERMINAL, point the HFOS_DIR var to the directory of the base project.
# For example:
#    $ export HFOS_DIR=$HOME/hellfireos
# Alternatively, you can also set this variable in the ~/.bashrc file.
#
# This makefile is a generic makefile to compile the objs and to create 
# static libs that will be linked by the main makefile. 
# This makefile is not meant to be called directly by the used. 
# It is called by other makefiles.
#
# In the MAKE command, it is possible to define the other relevant variables:
#    V=1 : enables verbose mode
#    DEBUG=1: enables debug mode. Otherwise, the code is optimized for size
#
###############################################################################

# testing the requirements
ifndef HFOS_DIR
    $(error HFOS_DIR is undefined)
endif

# the name of the final static library
ifndef PROJECT_NAME
    $(error Please set the required PROJECT_NAME variable in your makefile.)
endif
$(warning XXXXXXXXXXXXX PROJECT_NAME=$(PROJECT_NAME))

# Be silent per default, but 'make V=1' will show all compiler calls.
ifneq ($(V),1)
Q := @
# Do not print "Entering directory ...".
MAKEFLAGS += --no-print-directory
endif

# tools
SIZE_SCRIPT = $(HFOS_DIR)/usr/tools/linker-map-summary/get-size.sh

# # if not defined, these are the default dirs
# APPDIR         ?= $(CURDIR)
# BINDIRBASE     ?= $(APPDIR)/bin
# BINDIR         ?= $(BINDIRBASE)/$(PLATFORM)
# BUILD_DIR      ?= $(HFOS_DIR)/build

# # make it absolute path 
# override BINDIR         := $(abspath $(BINDIR))
# override APPDIR         := $(abspath $(APPDIR))
# override BUILD_DIR      := $(abspath $(BUILD_DIR))

# $(shell mkdir -p $(BINDIR)
# $(shell mkdir -p $(BUILD_DIR)


# insert -I in front of every folder in INC_DIRS
INC_DIR   = $(patsubst %, -I%, $(INC_DIRS))
# insert -L in front of every folder in LIB_DIRS
LIB_DIR   = $(patsubst %, -L%, $(LIB_DIRS))
# insert -l in front of every LDLIBS
LIB_NAME  = $(patsubst %, -l%, $(LDLIBS))
# insert -D in front of every DDEFS
DEF_NAME  = $(patsubst %, -D%, $(DDEFS))


# transfer the defines and the include dirs to the compilers
CFLAGS   += $(INC_DIR) $(DEF_NAME)
CXXFLAGS += $(INC_DIR) $(DEF_NAME)
ASFLAGS  += 
#$(info $$INCLUDE_DIRS is [${INCLUDE_DIRS}])


# expand wildcards to the each type of source file
C_SRC   = $(wildcard $(C_SRCS))
ASM_SRC = $(wildcard $(ASM_SRCS))
CPP_SRC = $(wildcard $(CPP_SRCS))

# create a string with all obj names
OBJECTS  = $(ASM_SRC:.s=.o) $(C_SRC:.c=.o) $(CPP_SRC:.cpp=.o)
# I was trying to place all obj files under the BUILD_DIR, similar to
# https://spin.atomicobject.com/2016/08/26/makefile-c-projects/, but it didnt work
# i have to try it again
#BUILD_DIR ?= ./build
#SRC_FILES2 = $(notdir $(SRC_FILES))
#OBJECTS    := $(patsubst %.c,$(BUILD_DIR)/%.o,$(SRC_FILES2))
#$(info $$OBJECTS is [${OBJECTS}])


#
# makefile rules 
#

# rule used to create static library for the platform, the OS, libs, and drivers
all: init_rule $(OBJECTS)
	@printf "\n  STATIC LIB  $(PROJECT_NAME).a\n"
	$(Q)$(AR) -r -s $(PROJECT_NAME).a $(OBJECTS)
	@echo "\\033[1;33m \t----------COMPILATION FINISHED---------- \\033[0;39m"
	@printf "\n  REPORT    $(PROJECT_NAME).a\n"
	@# reporting objs included into the static library, removed unwanted coluns with awk, and sort the objs by their sizes
	$(Q)$(AR) -tv $(PROJECT_NAME).a | awk '{printf "%8s %s\n", $$3, $$8}' | sort -k 1n
	@# report text, data, bss and total size for each object. Then, use awk to sum these values and present the total
	@printf "\n"
	@echo "\\033[1;33m \t----------REPORTS FINISHED----------- \\033[0;39m"

%.o: %.c | $(OBJ_FOLDER)
	@printf "  CC     $<\n"
	$(Q)$(CC) -c $(CFLAGS)    -I . $< -o $@

%.o: %.cpp | $(OBJ_FOLDER)
	@printf "  CXX    $<\n"
	$(Q)$(CC) -c $(CXX_FLAGS) -I . $< -o $@

%.o: %.s | $(OBJ_FOLDER)
	@printf "  AS     $<\n"
	$(Q)$(AS) -c $(ASFLAGS) $< -o $@

init_rule:
	@echo "\\033[1;33m \t----------COMPILATION STARTED----------- \\033[0;39m"

.PHONY: clean
clean:
	$(Q)-rm -rf $(OBJECTS)
	$(Q)-rm -rf $(OBJECTS:.o=.su)
	$(Q)-find . -type f -name '*.o' -delete
	$(Q)-find . -type f -name '*.su' -delete
	$(Q)-rm -rf $(BUILD_DIR)
	$(Q)-rm -rf $(PROJECT_NAME).elf
	$(Q)-rm -rf $(PROJECT_NAME).map
	$(Q)-rm -rf $(PROJECT_NAME).hex
	$(Q)-rm -rf $(PROJECT_NAME).bin
	$(Q)-rm -rf $(PROJECT_NAME).txt
	$(Q)-rm -rf $(PROJECT_NAME).a
	@echo "\\033[1;33m \t----------DONE CLEANING----------------- \\033[0;39m"
