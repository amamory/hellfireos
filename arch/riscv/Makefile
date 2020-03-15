#######################################################
# place here common definitions to any RISCV core design 
#######################################################

# if the application layer does not set a different prefix, then this one is the default
TOOLCHAIN_PREFIX ?= riscv32-unknown

export CC   = $(TOOLCHAIN_PREFIX)-elf-gcc
export CXX  = $(TOOLCHAIN_PREFIX)-elf-g++
export AS   = $(TOOLCHAIN_PREFIX)-elf-as
export AR   = $(TOOLCHAIN_PREFIX)-elf-ar
export LD   = $(TOOLCHAIN_PREFIX)-elf-ld
export DUMP = $(TOOLCHAIN_PREFIX)-elf-objdump
export READ = $(TOOLCHAIN_PREFIX)-elf-readelf
export CP   = $(TOOLCHAIN_PREFIX)-elf-objcopy
export SIZE = $(TOOLCHAIN_PREFIX)-elf-size