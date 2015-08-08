include ../../debian/android_includes.mk

NAME = libcutils
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
          fs.c \
          multiuser.c \
          socket_inaddr_any_server.c \
          socket_local_client.c \
          socket_local_server.c \
          socket_loopback_client.c \
          socket_loopback_server.c \
          socket_network_client.c \
          sockets.c \
          ashmem-host.c \
          dlmalloc_stubs.c
OBJECTS = $(SOURCES:.c=.o)
CFLAGS += -fPIC -c -DANDROID_SMP=0
CPPFLAGS += $(ANDROID_INCLUDES) -I../include
LDFLAGS += -fPIC -shared -rdynamic -Wl,-rpath=/usr/lib/android \
           -Wl,-soname,$(NAME).so.5 -lpthread -lbsd -L../liblog -llog

build: $(OBJECTS)
	cc $^ -o $(NAME).so.${UPSTREAM_LIBVERSION} $(LDFLAGS)
	ar rs $(NAME).a $^
	ln -s $(NAME).so.${UPSTREAM_LIBVERSION} $(NAME).so
	ln -s $(NAME).so.${UPSTREAM_LIBVERSION} $(NAME).so.5

clean:
	rm -f *.so* *.a *.o

$(OBJECTS): %.o: %.c
	cc $< -o $@ $(CFLAGS) $(CPPFLAGS)