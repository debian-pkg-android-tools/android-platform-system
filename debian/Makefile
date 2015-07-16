MODULES = core/liblog core/libcutils core/libzipfile extra/f2fs_utils core/adb core/fastboot

build: $(MODULES)

$(MODULES):
	make -C core/liblog/ -f debian/liblog.mk
	make -C core/libcutils/ -f debian/libcutils.mk
	make -C core/libzipfile/ -f debian/libzipfile.mk
	make -C extra/f2fs_utils/ -f debian/f2fs_utils.mk
	make -C core/adb/ -f debian/adb.mk
	make -C core/fastboot -f debian/fastboot.mk

clean:
	$(foreach module, $(MODULES), make clean -C $(module) -f ../../debian/$(module).mk)