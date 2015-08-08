# ORDER IS IMPORTANT!

build:
	make -C core/liblog -f ../../debian/liblog.mk
	make -C libnativehelper -f ../debian/libnativehelper.mk
	make -C core/libcutils -f ../../debian/libcutils.mk
	make -C core/libbacktrace -f ../../debian/libbacktrace.mk
	make -C core/libutils -f ../../debian/libutils.mk
	make -C core/libziparchive -f ../../debian/libziparchive.mk
	make -C core/libsparse -f ../../debian/libsparse.mk
	make -C core/libzipfile -f ../../debian/libzipfile.mk
	make -C extra/f2fs_utils -f ../../debian/libf2fs_utils.mk
	make -C extra/ext4_utils -f ../../debian/libext4_utils.mk
	make -C core/adb -f ../../debian/adb.mk
	make -C core/fastboot -f ../../debian/fastboot.mk

clean:
	make clean -C core/adb -f ../../debian/adb.mk
	make clean -C core/fastboot -f ../../debian/fastboot.mk
	make clean -C core/libbacktrace -f ../../debian/libbacktrace.mk
	make clean -C core/libcutils -f ../../debian/libcutils.mk
	make clean -C core/liblog -f ../../debian/liblog.mk
	make clean -C core/libsparse -f ../../debian/libsparse.mk
	make clean -C core/libutils -f ../../debian/libutils.mk
	make clean -C core/libziparchive -f ../../debian/libziparchive.mk
	make clean -C core/libzipfile -f ../../debian/libzipfile.mk
	make clean -C extra/ext4_utils -f ../../debian/libext4_utils.mk
	make clean -C extra/f2fs_utils -f ../../debian/libf2fs_utils.mk
	make clean -C libnativehelper -f ../debian/libnativehelper.mk