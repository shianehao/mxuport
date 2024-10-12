#-------------------------------------------------------------------------------
#   Makefile for MOXA UPort series drvier
#-------------------------------------------------------------------------------
KVER	 := $(shell uname -r)
KDISVER  := $(shell uname -a)
KDIR	 := /lib/modules/$(KVER)/build
PWD	 := $(shell pwd)
TARGET	 := mxuport

ifeq ($(KERNELRELEASE),)
	include $(PWD)/ver.mk
else
endif

export DRV_VER
export REL_DATE

all:	modules

install: modules
	@cp -f 91-mxuport-naming.rules /etc/udev/rules.d
#	@service udev restart
	@udevadm control --reload-rules && udevadm trigger
	@make -s -C mxuport install
	@depmod -a
	@echo " "
	@echo "************************************************************************"
	@echo " MOXA UPort 1200/1400/1600 series driver ver $(DRV_VER) installed successfully."
	@echo "************************************************************************"

ifneq ($(KERNELRELEASE),)
obj-y := mxuport/
else

modules: envchk

	@$(MAKE) EXTRA_CFLAGS=$(MXPARM) -C $(KDIR) M=$(PWD) modules 2>> build.log \
	&& cp -f ./build.log ../build.log \
	&& exit 0 \
	|| echo "Build Fail! Please chech build.log for further information." \
	&& cp -f ./build.log ../build.log \
	&& exit 1

endif

envchk:
	@./mxconf | tee build.log

remove:
	@make -s -C mxuport remove
	@depmod -a
	@rm -f /etc/udev/rules.d/91-mxuport-naming.rules
	@echo ""
	@echo "************************************************************************"
	@echo " MOXA UPort 1200/1400/1600 series driver ver $(DRV_VER) removed successfully."
	@echo "************************************************************************"


clean: clean_local clean_lib

clean_local:
	@echo; echo -n "Removing driver files..."
	@make -s -C mxuport clean
	@rm -rf ./.tmp_versions
	@rm -f *.symvers
	@rm -f *.order
	@rm -f *.markers
	@rm -rf ../.tmp*
	@rm -f .cache.mk
	@rm -f .Module.symvers.cmd
	@rm -f .modules.order.cmd

clean_lib:
	@rm -f /lib/modules/$(KVER)/kernel/drivers/usb/serial/$(TARGET_DRIVER).ko
	@rm -rf ../output
	@rm -f ../*.log
	@rm -f ./*.log
	@echo ""
	@echo "************************************************************************"
	@echo " MOXA UPort 1200/1400/1600 series driver ver $(DRV_VER) removed successfully."
	@echo "************************************************************************"
