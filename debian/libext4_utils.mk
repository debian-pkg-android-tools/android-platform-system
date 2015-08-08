include ../../debian/android_includes.mk

NAME = libext4_utils
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
CFLAGS += -fPIC -c
CPPFLAGS += $(ANDROID_INCLUDES) \
            -I../../core/include \
            -I../../core/libsparse/include \
            -I/usr/include/android
LDFLAGS += -fPIC -shared -rdynamic -Wl,-rpath=/usr/lib/android \
           -Wl,-soname,$(NAME).so.5 -lz \
           -L../../core/libsparse -lsparse \
           -L/usr/lib/android -lselinux

build: $(OBJECTS)
	cc $^ -o $(NAME).so.${UPSTREAM_LIBVERSION} $(LDFLAGS)
	ar rs $(NAME).a $^
	ln -s $(NAME).so.${UPSTREAM_LIBVERSION} $(NAME).so
	ln -s $(NAME).so.${UPSTREAM_LIBVERSION} $(NAME).so.5

clean:
	rm -f *.so* *.a *.o

$(OBJECTS): %.o: %.c
	cc $< -o $@ $(CFLAGS) $(CPPFLAGS)