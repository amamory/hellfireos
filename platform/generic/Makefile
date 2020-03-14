#######################################################
# This makefile has platform/system/board specific definitions only
# This platform is called generic because it consists only of a single CPU core
# and this CPU core can be set at the app makefile
#######################################################

# select here the family of processors used in this platform: arm, mips, or riscv ?
CPU_FAMILY ?= riscv
# select here the cpu design: check the dir $(HFOS)/arch/$(CPU_FAMILY) to the se supported CPUs
CPU_DESIGN ?= hf-risc
# at the app makefile level, the user can overwrite these two definitions above to change the type of CPU

# list here the features provided by this board: eth, serial, spi, i2c, noc, sdcard, ... 
# check the drivers dir to see the list of driver resources
# for instance, any memory mapped device outside the CPU core should be defined here
FEATURES_PROVIDED += 

# place here ONLY flags related to this specific CPU implementation. This means that ANY app using this CPU will have these flags
ASFLAGS  += 
CFLAGS   += 
CXXFLAGS += 
LDFLAGS  += 
LDLIBS   += 
# insert here the platform's specific defines 
DDEFS    +=

# list here all dirs with required include files
INC_DIRS += 

# list here all dirs with required static libs 
LIB_DIRS += 

# list here all source files in C
C_SRCS += 

# list here all source files in ASM
ASM_SRCS += 

# list here all source files in C++
CPP_SRCS += 

# it is possible to define wildcards to C_SRCS, ASM_SRCS, CPP_SRCS
#C_SRCS += ./my_lovely_dir/*.c


# jump to set compiler definitions related to the cpu family and design
include $(HFOS)/arch/$(CPU_FAMILY)/Makefile