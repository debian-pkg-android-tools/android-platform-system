include ../../debian/android_includes.mk

NAME = fastboot
SOURCES = protocol.c engine.c bootimg.c fastboot.c util.c fs.c usb_linux.c util_linux.c
CFLAGS += -fPIC -std=gnu99 -DUSE_F2FS
CPPFLAGS += $(ANDROID_INCLUDES) \
            -I../include \
            -I../mkbootimg \
            -I../../extra/ext4_utils \
            -I../../extra/f2fs_utils \
            -I/usr/include/openssl \
            -I../libsparse/include
LDFLAGS += -fPIC -rdynamic -Wl,-rpath=/usr/lib/android -ldl -lz \
           -L../libzipfile -lzipfile \
           -L../../extra/ext4_utils -lext4_utils \
           -L../libsparse -lsparse \
           -L../../extra/f2fs_utils -lf2fs_utils

build: $(SOURCES)
	cc $^ -o $(NAME) $(CFLAGS) $(CPPFLAGS) $(LDFLAGS)

clean:
	rm -f $(NAME)