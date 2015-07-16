include ../../debian/android_includes.mk

NAME = adb
SOURCES = adb.c \
          console.c \
          transport.c \
          transport_local.c \
          transport_usb.c \
          commandline.c \
          adb_client.c \
          adb_auth_host.c \
          sockets.c \
          services.c \
          file_sync_client.c \
          get_my_path_linux.c \
          usb_linux.c \
          usb_vendors.c \
          fdevent.c
OBJECTS = $(SOURCES:.c=.o)
INCLUDES = $(ANDROID_INCLUDES) -I../include -I/usr/include/openssl/
LOCAL_CFLAGS = -fPIC -c -DADB_HOST=1 -DADB_HOST_ON_TARGET=1 -D_XOPEN_SOURCE -D_GNU_SOURCE
LOCAL_LDFLAGS = -fPIC -rdynamic -Wl,-rpath=/usr/lib/android \
                -lpthread -lz -lcrypto \
                -L../libzipfile/ -lzipfile \
								-L../libcutils/ -lcutils \
								-L../liblog/ -llog

build: $(OBJECTS)
	cc $^ -o $(NAME) $(LDFLAGS) $(LOCAL_LDFLAGS)

clean:
	rm -f $(NAME) *.a *.o

$(OBJECTS): %.o: %.c
	cc $< -o $@ $(CFLAGS) $(CPPFLAGS) $(INCLUDES) $(LOCAL_CFLAGS)