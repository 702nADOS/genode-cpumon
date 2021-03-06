SEL4_DIR := $(call select_from_ports,sel4)/src/kernel/sel4

#
# Execute the kernel build only at the second build stage when we know
# about the complete build settings (e.g., the 'CROSS_DEV_PREFIX') and the
# current working directory is the library location.
#
ifeq ($(called_from_lib_mk),yes)
all: build_kernel
else
all:
endif

LINKER_OPT_PREFIX := -Wl,

build_kernel:
	$(VERBOSE)$(MAKE) \
	          TOOLPREFIX=$(CROSS_DEV_PREFIX) \
	          ARCH=ia32 PLAT=pc99 DEBUG=1 \
	          LDFLAGS+=-nostdlib LDFLAGS+=-Wl,-nostdlib \
	          $(addprefix LDFLAGS+=$(LINKER_OPT_PREFIX),$(LD_MARCH)) \
	          CFLAGS+=-fno-builtin-printf \
	          $(addprefix CFLAGS+=,$(CC_MARCH)) \
	          CONFIG_KERNEL_EXTRA_CPPFLAGS+=-DCONFIG_MAX_NUM_IOAPIC=1 \
	          CONFIG_KERNEL_EXTRA_CPPFLAGS+=-DCONFIG_IRQ_IOAPIC=1 \
	          CONFIG_KERNEL_EXTRA_CPPFLAGS+=-DCONFIG_NUM_DOMAINS=1 \
	          SOURCE_ROOT=$(SEL4_DIR) -f$(SEL4_DIR)/Makefile

