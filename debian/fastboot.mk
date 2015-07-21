include ../../debian/android_includes.mk

NAME = fastboot
SOURCES = protocol.c engine.c bootimg.c fastboot.c util.c fs.c usb_linux.c util_linux.c
OBJECTS = $(SOURCES:.c=.o)
INCLUDES = $(ANDROID_INCLUDES) \
           -I../include/ \
           -I../mkbootimg/ \
           -I../../extras/ext4_utils/ \
           -I../../extras/f2fs_utils/ \
           -I/usr/include/openssl/
LOCAL_CFLAGS = -fPIC -c -std=gnu99 -DUSE_F2FS
LOCAL_LDFLAGS = -fPIC -rdynamic -Wl,-rpath=/usr/lib/android \
                -lpthread -ldl -lz \
                -L../libzipfile/ -lzipfile \
                -L../../extra/ext4_utils/ -lext4_utils \
                -L../libsparse/ -lsparse \
                -L../../extra/f2fs_utils/ -lf2fs_utils -lf2fs_ioutils -lf2fs_dlutils

build: $(OBJECTS)
	cc $^ -o $(NAME) $(LDFLAGS) $(LOCAL_LDFLAGS)

clean:
	rm -f $(NAME) *.o

$(OBJECTS): %.o: %.c
	cc $< -o $@ $(CFLAGS) $(CPPFLAGS) $(INCLUDES) $(LOCAL_CFLAGS)