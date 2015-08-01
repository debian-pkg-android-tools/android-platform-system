include ../../debian/android_includes.mk

NAME = libf2fs_utils
SOURCES = f2fs_utils.c f2fs_ioutils.c f2fs_dlutils.c make_f2fs_main.c
OBJECTS = $(SOURCES:.c=.o)
CFLAGS += -fPIC -c
CPPFLAGS += $(ANDROID_INCLUDES) \
           -I../../core/include \
           -I/usr/include/f2fs-tools \
           -I/usr/include/f2fs-tools/mkfs \
           -I../../core/libsparse/include \
           -include stddef.h \
           -I/usr/include/android
LDFLAGS += -fPIC -shared -Wl,-soname,libf2fs_utils.so.5 \
           -Wl,-rpath=/usr/lib/android -luuid -lz -ldl -lf2fs -lf2fs_format \
           -L../../core/libsparse -lsparse

build: $(OBJECTS)
	cc $^ -o libf2fs_utils.so $(LDFLAGS)
	ar rs $(NAME).a $^

clean:
	rm -f *.so *.a *.o

$(OBJECTS): %.o: %.c
	cc $< -o $@ $(CFLAGS) $(CPPFLAGS)