include ../../debian/android_includes.mk

NAME = liblog
SOURCES = event_tag_map.c fake_log_device.c logd_write.c logprint.c uio.c
OBJECTS = $(SOURCES:.c=.o)
CFLAGS += -fPIC -c -DFAKE_LOG_DEVICE=1
CPPFLAGS += $(ANDROID_INCLUDES) -I../include
LDFLAGS += -fPIC -shared -Wl,-rpath=/usr/lib/android \
           -Wl,-soname,$(NAME).so.5 -lrt

build: $(OBJECTS)
	cc $^ -o $(NAME).so $(LDFLAGS)
	ar rs $(NAME).a $^

clean:
	rm -f *.so *.a *.o

$(OBJECTS): %.o: %.c
	cc $< -o $@ $(CFLAGS) $(CPPFLAGS)