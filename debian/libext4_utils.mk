include ../../debian/android_includes.mk

NAME = libext4_utils
VERSION = $(shell cat ../../debian/UPSTREAM_VERSION)
SOURCES = make_ext4fs.c \
          ext4fixup.c \
          ext4_utils.c \
          allocate.c \
          contents.c \
          extent.c \
          indirect.c \
          uuid.c \
          sha1.c \
          wipe.c \
          crc16.c \
          ext4_sb.c
OBJECTS = $(SOURCES:.c=.o)
INCLUDES = $(ANDROID_INCLUDES) \
           -I../../core/include/ \
           -I../../core/libsparse/include/ \
           -I/usr/include/android/
LOCAL_CFLAGS = -fPIC -c
LOCAL_LDFLAGS = -fPIC -shared -rdynamic -Wl,-rpath=/usr/lib/android/ \
                -Wl,-soname,$(NAME).so.5 \
                -lpthread -lz \
                -L../../core/libsparse/ -lsparse \
                -L/usr/lib/android/ -lselinux

build: $(OBJECTS)
	cc $^ -o $(NAME).so.$(VERSION) $(LDFLAGS) $(LOCAL_LDFLAGS)
	ar rs $(NAME).a $^

clean:
	rm -f *.so.* *.a *.o

$(OBJECTS): %.o: %.c
	cc $< -o $@ $(CFLAGS) $(CPPFLAGS) $(INCLUDES) $(LOCAL_CFLAGS)