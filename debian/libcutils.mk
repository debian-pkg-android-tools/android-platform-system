NAME = libcutils
SOURCES = hashmap.c \
          atomic.c \
          native_handle.c \
          config_utils.c \
          load_file.c \
          strlcpy.c \
          open_memstream.c \
          strdup16to8.c \
          strdup8to16.c \
          record_stream.c \
          process_name.c \
          threads.c \
          sched_policy.c \
          iosched_policy.c \
          str_parms.c \
          fs_config.c \
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
          trace-host.c \
          dlmalloc_stubs.c
SOURCES := $(foreach source, $(SOURCES), core/libcutils/$(source))
OBJECTS = $(SOURCES:.c=.o)
CFLAGS += -fPIC -c
CPPFLAGS += -include core/include/arch/linux-$(CPU)/AndroidConfig.h -Icore/include
LDFLAGS += -fPIC -shared -Wl,-soname,$(NAME).so.$(ANDROID_SOVERSION) \
           -Wl,-rpath=/usr/lib/android -lpthread -L. -llog

build: $(OBJECTS)
	$(CC) $^ -o $(NAME).so.$(ANDROID_LIBVERSION) $(LDFLAGS)
	$(AR) rs $(NAME).a $^
	ln -s $(NAME).so.$(ANDROID_LIBVERSION) $(NAME).so
	ln -s $(NAME).so.$(ANDROID_LIBVERSION) $(NAME).so.$(ANDROID_SOVERSION)

clean:
	$(RM) $(OBJECTS)

$(OBJECTS): %.o: %.c
	$(CC) $< -o $@ $(CFLAGS) $(CPPFLAGS)