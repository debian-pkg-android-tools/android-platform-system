include ../../debian/android_includes.mk

NAME = liblog
VERSION = $(shell cat ../../debian/UPSTREAM_VERSION)
SOURCES = event_tag_map.c fake_log_device.c logd_write.c logprint.c uio.c
OBJECTS = $(SOURCES:.c=.o)
INCLUDES = $(ANDROID_INCLUDES) -I../include
LOCAL_CFLAGS = -DFAKE_LOG_DEVICE=1 -fPIC -c
LOCAL_LDFLAGS = -fPIC -shared -rdynamic -Wl,-rpath=/usr/lib/android \
                -Wl,-soname,$(NAME).so.5 \
                -lrt -lpthread

build: $(OBJECTS)
	cc $^ -o $(NAME).so $(LDFLAGS) $(LOCAL_LDFLAGS)
	ar rs $(NAME).a $^

clean:
	rm -f *.so *.a *.o

$(OBJECTS): %.o: %.c
	cc $< -o $@ $(CFLAGS) $(CPPFLAGS) $(INCLUDES) $(LOCAL_CFLAGS)