#-------------------------------------------------------------------------------
#   Makefile for MOXA UPort series drvier
#-------------------------------------------------------------------------------
KVER	 := $(shell uname -r)
KDISVER  := $(shell uname -a)
KDIR	 := /lib/modules/$(KVER)/build
PWD	 := $(shell pwd)
TARGET	 := mxuport

#DBG_CFLAGS := -g -DDEBUG
MXPARM += ${DBG_CFLAGS}
CC += ${DBG_CFLAGS}
ccflags-y += ${DBG_CFLAGS}

all:	module

install: module
	@mkdir -p /lib/modules/$(KVER)/kernel/drivers/usb/serial
	@cp -f ./$(TARGET).ko /lib/modules/$(KVER)/kernel/drivers/usb/serial
	@mkdir -p /lib/modules/$(KVER)/misc/
	@cp -f ./$(TARGET).ko /lib/modules/$(KVER)/misc/
	@depmod -a

ifneq ($(KERNELRELEASE),)
obj-m := $(TARGET).o
$(TARGET)-objs := mx-uport.o
else
module:
	$(MAKE) EXTRA_CFLAGS="$(MXPARM)" -C $(KDIR) M=$(PWD) modules
endif

remove:
	@echo;echo -n "Removing drivers, please wait..."
	@rm -f /lib/modules/$(KVER)/kernel/drivers/usb/serial/$(TARGET).ko
	@rm -f /lib/modules/$(KVER)/misc/$(TARGET).ko
	@if lsmod | grep -q $(TARGET) ; then \
		rmmod $(TARGET); \
	 fi
	@depmod -a

clean: 
	@rm -f compile-msg 
	@rm -f *.o
	@rm -f .*.o.cmd
	@rm -f *.symvers
	@rm -f *.order
	@rm -rf ./.tmp_versions
	@rm -f $(TARGET).mod*
	@rm -f .$(TARGET)*
	@rm -f $(TARGET).ko
	@rm -f .Module.symvers.cmd
	@rm -f .modules.order.cmd
	@rm -f *.dwo

