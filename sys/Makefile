#######################################################
# This is the OS makefile
#######################################################

ifndef HFOS_DIR
    $(error HFOS_DIR is undefined. Please the path to Hellfire OS.)
endif

# place here ONLY flags related to the OS. No hardware, or app related flags should be included here !!!!
ASFLAGS  += 
CFLAGS   +=
CXXFLAGS += 
LDFLAGS  += 
LDLIBS   += 
# insert here the OS's specific defines
DDEFS    +=

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

# include the drivers requested by the application
$(foreach module,$(DRIVERS_REQUIRED),$(eval include $(HFOS_DIR)/driver/$(module).mk))
#$(info $$DRIVERS_REQUIRED is [${DRIVERS_REQUIRED}])

# include the libraries requested by the application
$(foreach module,$(LIBS_REQUIRED),$(eval include $(HFOS_DIR)/lib/$(module).mk))
#$(info $$LIBS_REQUIRED is [${LIBS_REQUIRED}])