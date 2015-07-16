include ../../debian/android_includes.mk

NAME = liblog
SOURCES = event_tag_map.c fake_log_device.c logd_write.c logprint.c uio.c
OBJECTS = $(SOURCES:.c=.o)
INCLUDES = $(ANDROID_INCLUDES) -I../include
LOCAL_CFLAGS = -DFAKE_LOG_DEVICE=1 -fPIC -c
LOCAL_LDFLAGS = -fPIC -shared -rdynamic -Wl,-rpath=/usr/lib/android -lrt -lpthread

build: $(OBJECTS)
	cc $^ -o $(NAME).so.5.1.1.8 -Wl,-soname,$(NAME).so.5 $(LDFLAGS) $(LOCAL_LDFLAGS)
	ar rs $(NAME).a $^

clean:
	rm -f *.so.* *.a *.o

$(OBJECTS): %.o: %.c
	cc $< -o $@ $(CFLAGS) $(CPPFLAGS) $(INCLUDES) $(LOCAL_CFLAGS)