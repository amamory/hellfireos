#######################################################
# This is the OS makefile
#######################################################

ifndef HFOS_DIR
    $(error HFOS_DIR is undefined. Please the path to Hellfire OS.)
endif

# CPU_FAMILY is arm, or mips, or riscv
ifndef CPU_FAMILY
    $(error CPU_FAMILY is undefined. Please select a supported CPU family in $(HFOS)/arch/)
endif

# CPU_DESIGN depends on the selected CPU_FAMILY. For instance, for mips there is support to hf-risc, pic32mz, and plasma
ifndef CPU_DESIGN
    $(error CPU_DESIGN is undefined. Please select a CPU design (in $(HFOS)/arch/$(CPU_FAMILY)) supported by the CPU family $(CPU_FAMILY))
endif

# the name OS static library
PROJECT_NAME = hellfire_os

# place here ONLY flags related to the OS. No hardware, or app related flags should be included here !!!!
ASFLAGS  += 
CFLAGS   +=
CXXFLAGS += 
LDFLAGS  += 
LDLIBS   += 

# this OS parameter cannot be changed in the app makefile
CPU_ARCH   = \"$(CPU_FAMILY)_$(CPU_DESIGN)\"

# default values for the OS parameters. These values can be overwritten in the app makefile
MAX_TASKS  ?= 30
MUTEX_TYPE ?= 0
MEM_ALLOC  ?= 3
HEAP_SIZE  ?= 500000
FLOATING_POINT ?= 0
KERNEL_LOG ?= 2

#TODO sergio, are all these defines required by the OS, or by some drivers ?!?!
# insert here the OS's specific defines
DDEFS    += CPU_ARCH=$(CPU_ARCH) MAX_TASKS=$(MAX_TASKS) MEM_ALLOC=$(MEM_ALLOC) HEAP_SIZE=$(HEAP_SIZE) \
	MUTEX_TYPE=$(MUTEX_TYPE) FLOATING_POINT=$(FLOATING_POINT) KERNEL_LOG=$(KERNEL_LOG) TERM_BAUD=$(SERIAL_BAUD)

# list here all dirs with required include files
INC_DIRS += ./include

# list here all dirs with required static libs 
LIB_DIRS += 

# list here all source files in C
C_SRCS += ./kernel/*.c
C_SRCS += ./lib/*.c
C_SRCS += ./sync/*.c

# list here all source files in ASM
ASM_SRCS += 

# list here all source files in C++
CPP_SRCS += 

# it is possible to define wildcards to C_SRCS, ASM_SRCS, CPP_SRCS
#C_SRCS += ./my_lovely_dir/*.c

# compile the platform, i.e. the hardware dependent software. It also defines the toolchain 
cd $(HFOS_DIR)/platform/$(PLATFORM) && make all

# the main rules
include $(HFOS_DIR)/Makefile.rules