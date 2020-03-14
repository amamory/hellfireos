#######################################################
# place here common definitions to any RISCV core design
#######################################################

# testing the requirements
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

$(info Selecting CPU Family $(CPU_FAMILY).)

# if the application layer does not set a different prefix, then this one is the default
TOOLCHAIN_PREFIX ?= riscv32-unknown

CC   = $(TOOLCHAIN_PREFIX)-elf-gcc
CXX  = $(TOOLCHAIN_PREFIX)-elf-g++
AS   = $(TOOLCHAIN_PREFIX)-elf-as
LD   = $(TOOLCHAIN_PREFIX)-elf-ld
DUMP = $(TOOLCHAIN_PREFIX)-elf-objdump -Mno-aliases
READ = $(TOOLCHAIN_PREFIX)-elf-readelf
OBJ  = $(TOOLCHAIN_PREFIX)-elf-objcopy
SIZE = $(TOOLCHAIN_PREFIX)-elf-size

# now go the a specific implementation of RISCV cpu
ifneq ("$(wildcard $($(CPU_DESIGN)/Makefile))","")
	# this is the name of the static lib with CPU specific code only
	PROJECT_NAME = $(CPU_FAMILY)_$(CPU_DESIGN)
	# call the makefile for the selected cpu 
	include $(CPU_DESIGN)/Makefile
#else
	#$(error CPU_DESIGN \"$(CPU_DESIGN)\" not supported. Please select a CPU design (in $(HFOS_DIR)/arch/$(CPU_FAMILY)) supported by the CPU family $(CPU_FAMILY))
endif