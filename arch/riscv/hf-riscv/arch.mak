# this is stuff specific to this architecture

HFOS_DIR = $(abspath $(lastword $(SRC_DIR)))
ARCH_DIR = $(HFOS_DIR)/arch/$(ARCH)
INC_DIRS  = -I $(ARCH_DIR)/include
#$(info $$HFOS_DIR is [${HFOS_DIR}])

F_CLK=25000000
TIME_SLICE=0

CC   = riscv64-unknown-elf-gcc
AS   = riscv64-unknown-elf-as
LD   = riscv64-unknown-elf-ld
DUMP = riscv64-unknown-elf-objdump -Mno-aliases
READ = riscv64-unknown-elf-readelf
OBJ  = riscv64-unknown-elf-objcopy
SIZE = riscv64-unknown-elf-size

#remove unreferenced functions
CFLAGS_STRIP = -fdata-sections -ffunction-sections
LDFLAGS_STRIP = --gc-sections

# this is stuff used everywhere - compiler and flags should be declared (ASFLAGS, CFLAGS, LDFLAGS, LINKER_SCRIPT, CC, AS, LD, DUMP, READ, OBJ and SIZE).
# remember the kernel, as well as the application, will be compiled using the *same* compiler and flags!
ASFLAGS = -march=rv32i -mabi=ilp32 #-fPIC
#CFLAGS = -Wall -march=rv32i -mabi=ilp32 -O2 -c -mstrict-align -ffreestanding -nostdlib -ffixed-s10 -ffixed-s11 -fomit-frame-pointer $(INC_DIRS) -DCPU_SPEED=${F_CLK} -DTIME_SLICE=${TIME_SLICE} -DLITTLE_ENDIAN $(CFLAGS_STRIP) -DKERN_VER=\"$(KERNEL_VER)\" #-mrvc -fPIC -DDEBUG_PORT -msoft-float -fshort-double
CFLAGS = -Wall -march=rv32i -mabi=ilp32 -O2 -c -mstrict-align  --specs=nano.specs -nostdlib -Wno-pointer-sign \
	-Wno-implicit-function-declaration -Wno-int-conversion -ffixed-s10 -ffixed-s11 -fomit-frame-pointer $(INC_DIRS) \
	-DCPU_SPEED=${F_CLK} -DTIME_SLICE=${TIME_SLICE} -DLITTLE_ENDIAN $(CFLAGS_STRIP) -DKERN_VER=\"$(KERNEL_VER)\" 


# find the path to the libraries libc_nano, libm, and libgcc
DIR_LIB_GCC=$(shell $(CC)  -march=rv32i -mabi=ilp32 --print-file-name=libgcc.a)
DIR_LIB_C=$(shell $(CC)  -march=rv32i -mabi=ilp32 --print-file-name=libm.a)
LIB_DIR_LIST +=  $(dir $(abspath $(lastword $(DIR_LIB_GCC))))
LIB_DIR_LIST +=  $(dir $(abspath $(lastword $(DIR_LIB_C))))
LIB_DIR  = $(patsubst %, -L%, $(LIB_DIR_LIST))
#$(info $$LIB_DIR is [${LIB_DIR}])

LDFLAGS = -melf32lriscv $(LDFLAGS_STRIP) $(LIB_DIR)
LINKER_SCRIPT = $(ARCH_DIR)/hf-riscv.ld

hal:
	$(AS) $(ASFLAGS) -o crt0.o $(ARCH_DIR)/boot/crt0.s
	$(CC) $(CFLAGS) \
		$(ARCH_DIR)/drivers/interrupt.c \
		$(ARCH_DIR)/drivers/hal.c \
		$(ARCH_DIR)/drivers/eth_enc28j60.c \
		$(ARCH_DIR)/drivers/syscalls_usart.c
