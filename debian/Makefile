build:
	make -C core/adb/ -f debian/adb.mk
	make -C core/fastboot -f debian/fastboot.mk
	make -C core/libcutils/ -f debian/libcutils.mk
	make -C core/liblog/ -f debian/liblog.mk
	make -C core/libsparse/ -f debian/libsparse.mk
	make -C core/libzipfile/ -f debian/libzipfile.mk
	make -C extra/f2fs_utils/ -f debian/f2fs_utils.mk

clean:
	make clean -C core/adb/ -f debian/adb.mk
	make clean -C core/fastboot -f debian/fastboot.mk
	make clean -C core/libcutils/ -f debian/libcutils.mk
	make clean -C core/liblog/ -f debian/liblog.mk
	make clean -C core/libsparse/ -f debian/libsparse.mk
	make clean -C core/libzipfile/ -f debian/libzipfile.mk
	make clean -C extra/f2fs_utils/ -f debian/f2fs_utils.mk