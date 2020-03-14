#######################################################
# this makefile has CPU specific definitions only
#######################################################

# specify here the type of RISCV implemented in this CPU
RISCV_ARCH = rv32i
RISCV_ABI  = ilp32

#remove unreferenced functions
CFLAGS_STRIP = -fdata-sections -ffunction-sections

# place here ONLY flags related to this specific CPU implementation. This means that ANY app using this CPU will have these flags
ASFLAGS  += -march=$(RISCV_ARCH) -mabi=$(RISCV_ABI)
# TODO review with sergio if all these flags are cpu related or OS related. then, remove all OS related flags
CFLAGS   += -march=$(RISCV_ARCH) -mabi=$(RISCV_ABI) -c $(CFLAGS_STRIP) -mstrict-align -ffreestanding -nostdlib -ffixed-s10 -ffixed-s11 -fomit-frame-pointer
CXXFLAGS += -march=$(RISCV_ARCH) -mabi=$(RISCV_ABI) -c $(CFLAGS_STRIP) 
LDFLAGS  += -melf32lriscv --gc-sections
LDLIBS   += 
LINKER_SCRIPT = ./hf-riscv.ld

# list here all dirs with required include files
INC_DIRS += ./include

# list here all dirs with required static libs 
LIB_DIRS += 

# list here all source files in C
C_SRC += ./drivers/hal.c
C_SRC += ./drivers/interrupt.c
C_SRC += ./drivers/eth_enc28j60.c

# list here all source files in ASM
# this is the startup code
ASM_SRC += ./boot/crt0.s

# list here all source files in C++
CPP_SRC += 

# insert here the lib's scpecific defines
# example: -DMY_LOVELY_DEFINE
DDEFS +=