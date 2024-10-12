DESCRIPTION = "Linux kernel module for Moxa UPort 1200/1400/1600 series"
LICENSE = "GPLv3"
LIC_FILES_CHKSUM = "file://COPYING-GPLV2.TXT;md5=5205bcd21ef6900c98e19cf948c26b41"

inherit module

SRC_URI = "file://Makefile \
           file://mx-uport.c \
           file://mx-uport.h \
           file://mx_ver.h \
           file://UPort1250FW.h \
           file://UPort1250IFW.h \
           file://UPort1410FW.h \
           file://UPort1450FW.h \
           file://UPort1450IFW.h \
           file://UPort1610_16FW.h \
           file://UPort1610_8FW.h \
           file://UPort1650_16FW.h \
           file://UPort1650_8FW.h \
           file://COPYING-GPLV2.TXT \
           "

S = "${WORKDIR}"

# The inherit of module.bbclass will automatically name module packages with
# "kernel-module-" prefix as required by the oe-core build environment.

RPROVIDES_${PN} += "kernel-module-mxuport"
