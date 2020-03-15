#######################################################
# this makefile has CPU specific definitions only
#######################################################

# testing the requirements
#ifndef PROJECT_NAME
#    $(error PROJECT_NAME is undefined. Please select a name for the generated files)
#endif

ifndef HFOS_DIR
    $(error HFOS_DIR is undefined. Please the path to Hellfire OS.)
endif

# CPU_DESIGN depends on the selected CPU_FAMILY. For instance, for mips there is support to hf-risc, pic32mz, and plasma
ifndef CPU_DESIGN
    $(error CPU_DESIGN is undefined. Please select a CPU design (in $(HFOS)/arch/$(CPU_FAMILY)) supported by the CPU family $(CPU_FAMILY))
endif

# add toolchain definition
#include $(HFOS_DIR)/arch/$(CPU_FAMILY)/$(CPU_DESIGN)/config.mk

# this parameter is dependent of the CPU Design, so it stays here where the user will not mess it up.
CPU_SPEED=25000000

# list here all dirs with required include files, without -I
INC_DIRS += $(HFOS_DIR)/arch/$(CPU_FAMILY)/$(CPU_DESIGN)/include
# HFOS include
INC_DIRS += $(HFOS_DIR)/sys/include

# insert here the lib's scpecific defines, without -D
DDEFS    += MAX_TASKS=$(MAX_TASKS) HEAP_SIZE=$(HEAP_SIZE) TERM_BAUD=$(TERM_BAUD) CPU_SPEED=$(CPU_SPEED)

# list here all source files in C. the extension must be .c
C_SRCS += $(HFOS_DIR)/arch/$(CPU_FAMILY)/$(CPU_DESIGN)/drivers/*.c 

# list here all source files in ASM. the extension must be .s
# this is the startup code
ASM_SRCS += $(HFOS_DIR)/arch/$(CPU_FAMILY)/$(CPU_DESIGN)/boot/crt0.s

# list here all source files in C++. the extension must be .cpp
CPP_SRCS += 

# it is possible to define wildcards to C_SRCS, ASM_SRCS, CPP_SRCS
#C_SRCS += ./my_lovely_dir/*.c
