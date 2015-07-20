include ../../debian/android_includes.mk

NAME = libsparse
VERSION = $(shell cat ../../debian/UPSTREAM_VERSION)
SOURCES = backed_block.c output_file.c sparse.c sparse_crc32.c sparse_err.c sparse_read.c
OBJECTS = $(SOURCES:.c=.o)
INCLUDES = $(ANDROID_INCLUDES) -I../include -Iinclude
LOCAL_CFLAGS = -DFAKE_LOG_DEVICE=1 -fPIC -c
LOCAL_LDFLAGS = -fPIC -shared -rdynamic -Wl,-rpath=/usr/lib/android -lz

build: $(OBJECTS)
	cc $^ -o $(NAME).so.$(VERSION) -Wl,-soname,$(NAME).so.5 $(LDFLAGS) $(LOCAL_LDFLAGS)
	ar rs $(NAME).a $^

clean:
	rm -f *.so.* *.a *.o

$(OBJECTS): %.o: %.c
	cc $< -o $@ $(CFLAGS) $(CPPFLAGS) $(INCLUDES) $(LOCAL_CFLAGS)