include ../../debian/android_includes.mk

NAME = libzipfile
VERSION = $(shell cat ../../debian/UPSTREAM_VERSION)
SOURCES = centraldir.c zipfile.c
OBJECTS = $(SOURCES:.c=.o)
INCLUDES = $(ANDROID_INCLUDES) -I../include
LOCAL_CFLAGS = -DFAKE_LOG_DEVICE=1 -fPIC -c
LOCAL_LDFLAGS = -fPIC -shared -rdynamic -Wl,-rpath=/usr/lib/android -lz

build: $(OBJECTS)
	cc $^ -o $(NAME).so.$(VERSION) -Wl,-soname,$(NAME).so.5 $(LDFLAGS) $(LOCAL_LDFLAGS)
	ar rs $(NAME).a $^

clean:
	rm -f *.so* *.a *.o

$(OBJECTS): %.o: %.c
	cc $< -o $@ $(CFLAGS) $(CPPFLAGS) $(INCLUDES) $(LOCAL_CFLAGS)