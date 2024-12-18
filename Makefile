PWD		:= $(shell pwd)
MX_VER_TXT	:= $(PWD)/version.txt
MX_VER_MK	:= $(PWD)/driver/ver.mk
MX_VER_H	:= $(PWD)/driver/mxuport/mx_ver.h
MX_BUILD_VER	:= $(shell awk '{if($$1=="Version" && $$2=="Number:"){print $$3}}' $(MX_VER_TXT))
MX_BUILD_DATE	:= $(shell awk '{if($$1=="Date:"){print $$2}}' $(MX_VER_TXT))
MX_CURR_DATE	:= $(shell date +%g%m%d%H)
#MX_BUILD_VER	:= $(strip $(MX_BUILD_VER))
#MX_BUILD_DATE	:= $(strip $(MX_BUILD_DATE))

all: driver_make

driver_make:
	@cd driver;\
	make -s

install:
	@cd driver;\
	make install -s

clean:
	@cd driver;\
	make clean -s

remove:
	@cd driver;\
	make remove -s

disk:	
ifeq (,$(wildcard $(MX_VER_MK)))
	@touch $(MX_VER_MK)
endif
	@sudo $(MAKE) remove
	@sudo $(MAKE) clean
	@rm -f $(MX_VER_MK)
	@echo -n "DRV_VER=" > $(MX_VER_MK)
	@echo "$(MX_BUILD_VER)" >> $(MX_VER_MK)
	@echo -n "REL_DATE=" >> $(MX_VER_MK)
	@echo "$(MX_BUILD_DATE)" >> $(MX_VER_MK)
	@echo "New $(MX_VER_MK) is created."
	@rm -f $(MX_VER_H)
	@echo "#ifndef _MX_VER_H_" >> $(MX_VER_H)
	@echo "#define _MX_VER_H_" >> $(MX_VER_H)
	@echo -n "#define DRIVER_VERSION \"ver" >> $(MX_VER_H)
	@echo -n "$(MX_BUILD_VER)" >> $(MX_VER_H)
	@echo "\"" >> $(MX_VER_H)
	@echo "#endif" >> $(MX_VER_H)
	@echo "New $(MX_VER_H) is created."
	rm -rfi ../../disk/*
	cp -f version.txt ../../disk
	cp -f readme.txt ../../disk
	tar -cvzf ../../disk/driv_linux_uport_v$(MX_BUILD_VER)_build_$(MX_CURR_DATE).tgz ../mxuport
	@echo "Done"


