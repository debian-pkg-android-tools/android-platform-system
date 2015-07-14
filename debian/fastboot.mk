include ../debian/android_includes.mk

NAME = fastboot
SOURCES = protocol.c engine.c bootimg.c fastboot.c util.c fs.c usb_linux.c util_linux.c
OBJECTS = $(SOURCES:.c=.o)
INCLUDES = $(ANDROID_INCLUDES) -I../include -I/usr/include/openssl/
LOCAL_CFLAGS = -fPIC -c -std=gnu99 -DUSE_F2FS
LOCAL_LDFLAGS = -fPIC -Wl,-rpath=/usr/lib/android -lpthread -lzipfile -lz 

build: $(OBJECTS)
	cc $^ -o $(NAME) $(LDFLAGS) $(LOCAL_LDFLAGS)

clean:
	rm -f $(NAME)

$(OBJECTS): %.o: %.c
	cc $< -o $@ $(CFLAGS) $(CPPFLAGS) $(INCLUDES) $(LOCAL_CFLAGS)