include ../../debian/android_includes.mk

NAME = libsparse
SOURCES = backed_block.c output_file.c sparse.c sparse_crc32.c sparse_err.c sparse_read.c
OBJECTS = $(SOURCES:.c=.o)
CFLAGS += -fPIC -c
CPPFLAGS += $(ANDROID_INCLUDES) -I../include -Iinclude
LDFLAGS += -fPIC -shared -Wl,-rpath=/usr/lib/android \
           -Wl,-soname,$(NAME).so.5 -lz

build: $(OBJECTS)
	cc $^ -o $(NAME).so.${UPSTREAM_LIBVERSION} $(LDFLAGS)
	ar rs $(NAME).a $^
	ln -s $(NAME).so.${UPSTREAM_LIBVERSION} $(NAME).so
	ln -s $(NAME).so.${UPSTREAM_LIBVERSION} $(NAME).so.5

clean:
	rm -f *.so* *.a *.o

$(OBJECTS): %.o: %.c
	cc $< -o $@ $(CFLAGS) $(CPPFLAGS)