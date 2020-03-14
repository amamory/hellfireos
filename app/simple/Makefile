#######################################################
# This is an example of  makefile for an application
#######################################################

PLATFORM = generic

# some platforms, such as the generic platform, allow the user to change the CPU_FAMILY and CPU_DESIGN.
# Just uncomment the following lines to set different processors
# select here the family of processors used in this platform: arm, mips, or riscv ?
CPU_FAMILY = riscv
# select here the cpu design: check the dir $(HFOS)/arch/$(CPU_FAMILY) to the se supported CPUs
CPU_DESIGN = hf-risc
# at the app makefile level, the user can overwrite these two definitions above to change the type of CPU

# It is also possible to replace the default toolchain prefix by setting this variable
TOOLCHAIN_PREFIX = riscv64-unknown

# list here the drivers required by this application: eth, serial, spi, i2c, noc, sdcard, ... 
# check the drivers under $(HFOS_DIR)/drivers dir to see the list of drivers
DRIVERS_REQUIRED += 

# the libraries listed under $(HFOS_DIR)/libs can be used at the application layer just by listing their lib names
LIBS_REQUIRED += 

# place here ONLY flags related to this specific application. No hardware or OS related flags should be included here !!!!
ASFLAGS  += 
CFLAGS   += 
CXXFLAGS += 
LDFLAGS  += 
LDLIBS   += 
# insert here the apps's specific defines
DDEFS    +=

# list here all dirs with required include files
INC_DIRS += 

# list here all dirs with required static libs 
LIB_DIRS += 

# list here all source files in C
C_SRCS += ./*.c

# list here all source files in ASM
ASM_SRCS += 

# list here all source files in C++
CPP_SRCS += 

# it is possible to define wildcards to C_SRCS, ASM_SRCS, CPP_SRCS
#C_SRCS += ./my_lovely_dir/*.c

# jump to set platform definitions
include $(HFOS)/platform/$(PLATFORM)/Makefile

# jump to set HFOS definitions
include $(HFOS)/sys/Makefile

# jump to the makefile rules
include $(HFOS)/Makefile.rules