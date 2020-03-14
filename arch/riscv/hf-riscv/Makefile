#######################################################
# this makefile has CPU specific definitions only
#######################################################

# testing the requirements
ifndef PROJECT_NAME
    $(error PROJECT_NAME is undefined. Please select a name for the generated files)
endif

echo "Selecting CPU Design $(CPU_DESIGN)."

# specify here the type of RISCV implemented in this CPU
RISCV_ARCH = rv32i
RISCV_ABI  = ilp32

# remove unreferenced functions
# Generate separate ELF section for each function. usefull for static libraries
#https://interrupt.memfault.com/blog/get-the-most-out-of-the-linker-map-file
#http://blog.atollic.com/the-ultimate-guide-to-reducing-code-size-with-gnu-gcc-for-arm-cortex-m
#https://stackoverflow.com/questions/4274804/query-on-ffunction-section-fdata-sections-options-of-gcc
CFLAGS_STRIP = -fdata-sections -ffunction-sections

# place here ONLY flags related to this specific CPU implementation. This means that ANY app using this CPU will have these flags
ASFLAGS  += -march=$(RISCV_ARCH) -mabi=$(RISCV_ABI)
# TODO review with sergio if all these flags are cpu related or OS related. then, remove all OS related flags
CFLAGS   += -march=$(RISCV_ARCH) -mabi=$(RISCV_ABI) -c $(CFLAGS_STRIP) -mstrict-align -ffreestanding -nostdlib -ffixed-s10 -ffixed-s11 -fomit-frame-pointer
CXXFLAGS += -march=$(RISCV_ARCH) -mabi=$(RISCV_ABI) -c $(CFLAGS_STRIP) 
LDFLAGS  += -melf32lriscv --gc-sections $(CFLAGS_STRIP) -Map=${PROJECT_NAME}.map
# the following flag might be usefull ... it prints something like this
#LD_FLAGS += -Wl,--print-memory-usage
#Memory region         Used Size  Region Size  %age Used
#             rom:       10800 B       256 KB      4.12%
#             ram:        8376 B        32 KB     25.56%

# this the linker script file, without -T
LINKER_SCRIPT = ./hf-riscv.ld

# list here all dirs with required include files, without -I
INC_DIRS += ./include

# list here all dirs with required static libs, without -L
LIB_DIRS += 
# list the required libs, without -l
LDLIBS   += 

# insert here the lib's scpecific defines, without -D
DDEFS +=

# list here all source files in C. the extension must be .c
#C_SRC += ./drivers/*.c 
C_SRCS += ./drivers/hal.c
C_SRCS += ./drivers/interrupt.c
C_SRCS += ./drivers/eth_enc28j60.c

# list here all source files in ASM. the extension must be .s
# this is the startup code
ASM_SRCS += ./boot/crt0.s

# list here all source files in C++. the extension must be .cpp
CPP_SRCS += 

# it is possible to define wildcards to C_SRCS, ASM_SRCS, CPP_SRCS
#C_SRCS += ./my_lovely_dir/*.c