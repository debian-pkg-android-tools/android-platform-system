include ../../debian/android_includes.mk

VERSION = $(shell cat ../../debian/UPSTREAM_VERSION)
SOURCES = f2fs_utils.c f2fs_ioutils.c f2fs_dlutils.c
OBJECTS = $(SOURCES:.c=.o)
INCLUDES = $(ANDROID_INCLUDES) \
           -I../../core/include/ \
           -I/usr/include/f2fs-tools/ \
           -I/usr/include/f2fs-tools/mkfs/ \
           -I../../core/libsparse/include/
LOCAL_CFLAGS = -fPIC -c
LOCAL_LDFLAGS = -fPIC -shared -rdynamic -Wl,-rpath=/usr/lib/android -lpthread

build: $(OBJECTS)
	cc f2fs_utils.o -o libf2fs_utils.so.$(VERSION) \
	   -Wl,-soname,libf2fs_utils.so.5 $(LDFLAGS) $(LOCAL_LDFLAGS) \
	   -L../../core/libsparse/ -lsparse -lz
	ar rs libf2fs_utils.a f2fs_utils.o

	cc f2fs_ioutils.o -o libf2fs_ioutils.so.$(VERSION) \
     -Wl,-soname,libf2fs_ioutils.so.5 $(LDFLAGS) $(LOCAL_LDFLAGS) \
	   -L../../core/libsparse/ -lsparse \
	   -L/usr/lib/android/ -lext2_uuid -lz
	ar rs libf2fs_ioutils.a f2fs_ioutils.o

	cc f2fs_utils.o -o libf2fs_dlutils.so.$(VERSION) \
	   -Wl,-soname,libf2fs_dlutils.so.5 $(LDFLAGS) $(LOCAL_LDFLAGS) -ldl
	ar rs libf2fs_dlutils.a f2fs_dlutils.o

clean:
	rm -f *.so.* *.a *.o

$(OBJECTS): %.o: %.c
	cc $< -o $@ $(CFLAGS) $(CPPFLAGS) $(INCLUDES) $(LOCAL_CFLAGS)