#######################################################
# cpu definitions that the rest of the software needs
#######################################################

ifndef HFOS_DIR
    $(error HFOS_DIR is undefined. Please the path to Hellfire OS.)
endif

# CPU_DESIGN depends on the selected CPU_FAMILY. For instance, for mips there is support to hf-risc, pic32mz, and plasma
ifndef CPU_DESIGN
    $(error CPU_DESIGN is undefined. Please select a CPU design (in $(HFOS_DIR)/arch/$(CPU_FAMILY)) supported by the CPU family $(CPU_FAMILY))
endif

# specify here the type of RISCV implemented in this CPU
RISCV_ARCH = rv32i
RISCV_ABI  = ilp32

# this the linker script file, without -T
#export LINKER_SCRIPT =  $(HFOS_DIR)/arch/$(CPU_FAMILY)/$(CPU_DESIGN)/hf-riscv.ld

# this parameter is dependent of the CPU Design, so it stays here where the user will not mess it up.
export CPU_SPEED=25000000

# add toolchain definition
include $(HFOS_DIR)/arch/$(CPU_FAMILY)/Makefile

# remove unreferenced functions
# Generate separate ELF section for each function. usefull for static libraries
#https://interrupt.memfault.com/blog/get-the-most-out-of-the-linker-map-file
#http://blog.atollic.com/the-ultimate-guide-to-reducing-code-size-with-gnu-gcc-for-arm-cortex-m
#https://stackoverflow.com/questions/4274804/query-on-ffunction-section-fdata-sections-options-of-gcc
COMMON_PARAM = -fdata-sections -ffunction-sections
#-fstack-usage will generate an extra file .su that specifies the maximum amount of stack used, on a per-function basis.
COMMON_PARAM += -fstack-usage
# the -Wstack-usage flag will make sure that the stack limit is not hit
ifndef STACK_SIZE
    $(error Please set the required STACK_SIZE variable in your makefile.)
endif
# -Wstack-usage=<stack_limit> emit a warning when stack usage exceeds a certain value
COMMON_PARAM  += -Wstack-usage=$(STACK_SIZE)

# place here ONLY flags related to this specific CPU implementation. This means that ANY app using this CPU will have these flags
export ASFLAGS  += -march=$(RISCV_ARCH) -mabi=$(RISCV_ABI) 
# TODO review with sergio if all these flags are cpu related or OS related. then, remove all OS related flags
export CFLAGS   += -march=$(RISCV_ARCH) -mabi=$(RISCV_ABI) -c $(COMMON_PARAM) -mstrict-align -ffreestanding -nostdlib -ffixed-s10 -ffixed-s11 -fomit-frame-pointer
export CXXFLAGS += -march=$(RISCV_ARCH) -mabi=$(RISCV_ABI) -c $(COMMON_PARAM) 
export LDFLAGS  += -Wl,-melf32lriscv  $(COMMON_PARAM) -Wl,--gc-sections -Wl,-Map=${PROJECT_NAME}.map -T$(HFOS_DIR)/arch/$(CPU_FAMILY)/$(CPU_DESIGN)/hf-riscv.ld
# the following flag might be usefull ... it prints something like this
#LD_FLAGS += -Wl,--print-memory-usage
#Memory region         Used Size  Region Size  %age Used
#             rom:       10800 B       256 KB      4.12%
#             ram:        8376 B        32 KB     25.56%

