include ../../debian/android_includes.mk

NAME = libsparse
SOURCES = backed_block.c output_file.c sparse.c sparse_crc32.c sparse_err.c sparse_read.c
OBJECTS = $(SOURCES:.c=.o)
CFLAGS += -fPIC -c
CPPFLAGS += $(ANDROID_INCLUDES) -I../include -Iinclude
LDFLAGS += -fPIC -shared -Wl,-rpath=/usr/lib/android \
           -Wl,-soname,$(NAME).so.5 -lz

build: $(OBJECTS)
	cc $^ -o $(NAME).so $(LDFLAGS)
	ar rs $(NAME).a $^

clean:
	rm -f *.so *.a *.o

$(OBJECTS): %.o: %.c
	cc $< -o $@ $(CFLAGS) $(CPPFLAGS)