#######################################################
# place here common definitions to any RISCV core design
#######################################################

# testing the requirements
# CPU_FAMILY is arm, or mips, or riscv
ifndef CPU_FAMILY
    $(error CPU_FAMILY is undefined. Please select a supported CPU family in $(HFOS)/arch/)
endif

# CPU_DESIGN depends on the selected CPU_FAMILY. For instance, for mips there is support to hf-risc, pic32mz, and plasma
ifndef CPU_DESIGN
    $(error CPU_DESIGN is undefined. Please select a CPU design (in $(HFOS)/arch/$(CPU_FAMILY)) supported by the CPU family $(CPU_FAMILY))
endif

echo "Selecting CPU Family $(CPU_FAMILY)."

CC   = riscv32-unknown-elf-gcc
CXX  = riscv32-unknown-elf-g++
AS   = riscv32-unknown-elf-as
LD   = riscv32-unknown-elf-ld
DUMP = riscv32-unknown-elf-objdump -Mno-aliases
READ = riscv32-unknown-elf-readelf
OBJ  = riscv32-unknown-elf-objcopy
SIZE = riscv32-unknown-elf-size

# now go the a specific implementation of RISCV cpu
ifneq ("$(wildcard $($(CPU_DESIGN)/Makefile))","")
	# this is the name of the static lib with CPU specific code only
	PROJECT_NAME = $(CPU_FAMILY)_$(CPU_DESIGN)
	# call the makefile for the selected cpu 
	include $(CPU_DESIGN)/Makefile
else
	$(error CPU_DESIGN \"$(CPU_DESGIN)\" not supported. Please select a CPU design (in $(HFOS)/arch/$(CPU_FAMILY)) supported by the CPU family $(CPU_FAMILY))
endif