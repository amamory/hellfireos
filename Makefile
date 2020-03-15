
###############################################################################
#
# Makefile for compiling STM32F1xx devices, specially, STM32F103C8T6 or bluepill
# Copyright (C) 2020 Alexandre Amory <amamory@gmail.com>
#
###############################################################################
# RELEVANT VARIABLES:
#
# In the TERMINAL, point the LEARNING_STM32 to the directory of the base project.
# For example:
#
#    $ export LEARNING_STM32=$HOME/learning-stm32
#
# Alternatively, you can also set this variable in the ~/.bashrc file.
#
#
# In the MAKE command, it is possible to define the other relevant variables:
#
#    V=1 : enables verbose mode
#    DEBUG=1: enables debug mode. Otherwise, the code is optimized for size
#
# Usage example:
#    $ make V=1 <=== enables verbose mode
#    $ make DEBUG=1 V=1 <=== enables both verbose and debug modes
###############################################################################

# testing the requirements
ifndef HFOS_DIR
    $(error HFOS_DIR is undefined)
endif

ifndef PROJECT_NAME
    $(error Please set the required PROJECT_NAME variable in your makefile.)
endif

ifndef PLATFORM
    $(error Please set the required PLATFORM variable in your makefile.)
endif
export PLATFORM

# Be silent per default, but 'make V=1' will show all compiler calls.
ifneq ($(V),1)
Q := @
# Do not print "Entering directory ...".
MAKEFLAGS += --no-print-directory
endif

# tool to extract human readable size info from map files
SIZE_SCRIPT = $(HFOS_DIR)/usr/tools/linker-map-summary/get-size.sh

# if not defined, these are the default dirs
# APPDIR         ?= $(CURDIR)
# BINDIRBASE     ?= $(APPDIR)/bin
# BINDIR         ?= $(BINDIRBASE)/$(PLATFORM)
# BUILD_DIR      ?= $(HFOS_DIR)/build

# # make it absolute path 
# override BINDIR         := $(abspath $(BINDIR))
# override APPDIR         := $(abspath $(APPDIR))
# override BUILD_DIR      := $(abspath $(BUILD_DIR))

# $(shell mkdir -p $(BINDIR)
# $(shell mkdir -p $(BUILD_DIR)

# # image files
# ELFFILE ?= $(BINDIR)/$(APPLICATION).elf
# HEXFILE ?= $(ELFFILE:.elf=.hex)
# BINFILE ?= $(ELFFILE:.elf=.bin)

MAKEFLAGS += --no-print-directory


# include the app dir
MAKE_DIRS += $(HFOS_DIR)/app/$(PROJECT_NAME)
# get the info depedency and the main configurations
include $(HFOS_DIR)/app/$(PROJECT_NAME)/config.mk
# $(info $$CPU_FAMILY is [${CPU_FAMILY}])
# $(info $$CPU_DESIGN is [${CPU_DESIGN}])
# $(info $$STACK_SIZE is [${STACK_SIZE}])
# $(info $$MAX_TASKS is [${MAX_TASKS}])
# $(info $$DRIVERS_REQUIRED is [${DRIVERS_REQUIRED}])
# $(info $$LIBS_REQUIRED is [${LIBS_REQUIRED}])
# $(info $$TOOLCHAIN_PREFIX is [${TOOLCHAIN_PREFIX}])

# include the hardware dependent software
MAKE_DIRS += $(HFOS_DIR)/platform/$(PLATFORM)
# get the hardware related info
# get the toolchain info
include $(HFOS_DIR)/platform/$(PLATFORM)/config.mk
# $(info $$CPU_FAMILY is [${CPU_FAMILY}])
# $(info $$CPU_DESIGN is [${CPU_DESIGN}])
# $(info $$ASFLAGS is [${ASFLAGS}])
# $(info $$CFLAGS is [${CFLAGS}])
# $(info $$LDFLAGS is [${LDFLAGS}])
# $(info $$LINKER_SCRIPT is [${LINKER_SCRIPT}])
# $(info $$C_SRCS is [${C_SRCS}])
# $(info $$ASM_SRCS is [${ASM_SRCS}])
# $(info $$CC is [${CC}])

# # include the OS dir
# MAKE_DIRS += $(HFOS_DIR)/sys
# # get the info required by the next step
# include $(HFOS_DIR)/sys/deps.mk



# # compile the drivers requested by the applicatio
# $(foreach module,$(DRIVERS_REQUIRED),MAKE_DIRS += $(HFOS_DIR)/driver/$(module)))
# #$(info $$DRIVERS_REQUIRED is [${DRIVERS_REQUIRED}])

# # compile the libraries requested by the application
# $(foreach module,$(LIBS_REQUIRED),   MAKE_DIRS += $(HFOS_DIR)/lib/$(module))
# #$(info $$LIBS_REQUIRED is [${LIBS_REQUIRED}])

#
# makefile rules
#
.PHONY: $(MAKE_DIRS)

all: $(MAKE_DIRS) $(PROJECT_NAME).elf $(PROJECT_NAME).hex $(PROJECT_NAME).bin $(PROJECT_NAME).txt
	@echo "\\033[1;33m \t----------COMPILATION FINISHED---------- \\033[0;39m"
	@printf "\n  SIZE        $(PROJECT_NAME).elf\n"
	$(Q)$(SIZE) $(PROJECT_NAME).elf
	@printf "  MEM REPORT  $(PROJECT_NAME).elf\n"
	# other similar .map report tool https://fpv-gcc.readthedocs.io/en/latest/usage.html
	$(Q)python $(HFOS_DIR)/utils/linker-map-summary/analyze_map.py $(PROJECT_NAME).map
	@printf "\n"
	@echo "\\033[1;33m \t----------REPORTS FINISHED----------- \\033[0;39m"

clean: $(MAKE_DIRS)

# MAKECMDGOALS is special variable to the list of goals you specified on the command line
$(MAKE_DIRS):
	#cd $@ && make $(MAKECMDGOALS)
	$(MAKE) --directory=$@ $(MAKECMDGOALS)

%.elf: $(OBJECTS)
	@printf "  LD      $(*).elf\n"
	$(Q)$(LD) $(OBJECTS) $(LDFLAGS) -o $@

%.hex: %.elf
	@printf "  HEX $@\n"
	$(Q)$(HEX) -O ihex $< $@

%.bin: %.elf
	@printf "  BIN $@\n"
	$(Q)$(BIN) -O binary -S  $< $@

%.txt: %.bin
	@printf "  HEXDUMP $@\n"
	$(Q)hexdump -v -e '4/1 "%02x" "\n"' $< > $@

#init_rule:
#	@echo "\\033[1;33m \t----------COMPILATION STARTED----------- \\033[0;39m"

flash: $(PROJECT_NAME).bin
	@#st-flash write $(PROJECT_NAME).bin 0x8000000
	@# Make flash to the board by STM32CubeProgrammer v2.2.1
	STM32_Programmer.sh -c port=SWD -e all -d  $(PROJECT_NAME).bin 0x8000000 -v

debug:	$(PROJECT_NAME).elf
	$(GDB) --eval-command="target extended-remote :4242" $(PROJECT_NAME).elf

.PHONY: erase
erase:
	$(Q)st-flash erase



