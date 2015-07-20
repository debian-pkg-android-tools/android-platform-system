include ../../debian/android_includes.mk

NAME = libcutils
VERSION = $(shell cat ../../debian/UPSTREAM_VERSION)
SOURCES = hashmap.c \
          atomic.c \
          native_handle.c \
          config_utils.c \
          cpu_info.c \
          load_file.c \
          open_memstream.c \
          strdup16to8.c \
          strdup8to16.c \
          record_stream.c \
          process_name.c \
          threads.c \
          sched_policy.c \
          iosched_policy.c \
          str_parms.c \
					dlmalloc_stubs.c
OBJECTS = $(SOURCES:.c=.o)
INCLUDES = $(ANDROID_INCLUDES) -I../include
LOCAL_CFLAGS = -DANDROID_SMP=0 -fPIC -c
LOCAL_LDFLAGS = -fPIC -shared -rdynamic -Wl,-rpath=/usr/lib/android -L../liblog/ -lpthread -llog -lbsd

build: $(OBJECTS)
	cc $^ -o $(NAME).so.$(VERSION) -Wl,-soname,$(NAME).so.5 $(LDFLAGS) $(LOCAL_LDFLAGS)
	ar rs $(NAME).a $^

clean:
	rm -f *.so.* *.a *.o

$(OBJECTS): %.o: %.c
	cc $< -o $@ $(CFLAGS) $(CPPFLAGS) $(INCLUDES) $(LOCAL_CFLAGS)