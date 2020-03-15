# add here some platform specific definition

# select here the family of processors used in this platform: arm, mips, or riscv ?
export CPU_FAMILY ?= riscv
# select here the cpu design: check the dir $(HFOS)/arch/$(CPU_FAMILY) to the se supported CPUs
export CPU_DESIGN ?= hf-riscv
# at the app makefile level, the user can overwrite these two definitions above to change the type of CPU

# append its definition to the CPU definitions
include $(HFOS_DIR)/arch/$(CPU_FAMILY)/$(CPU_DESIGN)/config.mk
