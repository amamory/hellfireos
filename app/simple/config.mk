$(info ENTREI simple/config.mk)

#########################
# HARDWARE CONFIGURATION
#########################

# some platforms, such as the generic platform, allow the user to change the CPU_FAMILY and CPU_DESIGN.
# Just uncomment the following lines to set different processors
# select here the family of processors used in this platform: arm, mips, or riscv ?
#CPU_FAMILY = mips
# select here the cpu design: check the dir $(HFOS)/arch/$(CPU_FAMILY) to the se supported CPUs
#CPU_DESIGN = hf-risc
# at the app makefile level, the user can overwrite these two definitions above to change the type of CPU


# It is also possible to replace the default toolchain prefix by setting this variable
export TOOLCHAIN_PREFIX = riscv64-unknown

#########################
# OS CONFIGURATION
#########################

# the user can also change these OS parameters. If not set, the default will be used 
export MAX_TASKS = 30
export MUTEX_TYPE = 0
export MEM_ALLOC = 3
export HEAP_SIZE = 500000
export FLOATING_POINT = 0
export KERNEL_LOG = 2
export TERM_BAUD = 57600

# insert the max size of the stack. the -Wstack-usage flag will make sure that this limit is not hit
export STACK_SIZE = 255

#########################
# APP DEPEDENCIES 
#########################

# list here the drivers required by this application: eth, serial, spi, i2c, noc, sdcard, ...  
# check the drivers under $(HFOS_DIR)/drivers dir to see the list of drivers
DRIVERS_REQUIRED += device

# the libraries listed under $(HFOS_DIR)/libs can be used at the application layer just by listing their lib names
LIBS_REQUIRED += misc

$(info SAI simple/config.mk)
