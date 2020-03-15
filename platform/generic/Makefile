#######################################################
# This makefile has platform/system/board specific definitions only
# This platform is called generic because it consists only of a single CPU core
# and this CPU core can be set at the app makefile 
#######################################################

# testing the requirements
ifndef HFOS_DIR
    $(error HFOS_DIR is undefined. Please the path to Hellfire OS.)
endif

# CPU_DESIGN depends on the selected CPU_FAMILY. For instance, for mips there is support to hf-risc, pic32mz, and plasma
ifndef PLATFORM
    $(error PLATFORM is undefined. Please select a platform from $(HFOS)/platform)
endif

# the name of the static library with all the hardware software
# use overrride, otherwise it will get the PROJECT_NAME from the main makefile
override PROJECT_NAME = $(PLATFORM)
# add to the list of libs to be linked later
#export STATIC_LIBS += $(PROJECT_NAME)

#include $(HFOS_DIR)/platform/$(PLATFORM)/config.mk

#$(warning XXXXXXXXXXXXXX1 ASFLAGS = $(ASFLAGS))

# jump to set compiler definitions related to the cpu family and design
include $(HFOS_DIR)/arch/$(CPU_FAMILY)/$(CPU_DESIGN)/Makefile

$(info Selecting Platform '$(PLATFORM)', CPU Family '$(CPU_FAMILY)', and CPU Design '$(CPU_DESIGN)'.)

#$(warning XXXXXXXXXXXXXX2 ASFLAGS = $(ASFLAGS))

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


include $(HFOS_DIR)/Makefile.mk