include ../../debian/android_includes.mk

NAME = libzipfile
SOURCES = centraldir.c zipfile.c
OBJECTS = $(SOURCES:.c=.o)
CFLAGS += -fPIC -c
CPPFLAGS += $(ANDROID_INCLUDES) -I../include
LDFLAGS += -fPIC -shared -rdynamic -Wl,-rpath=/usr/lib/android -lz \
          -Wl,-soname,$(NAME).so.5

build: $(OBJECTS)
	cc $^ -o $(NAME).so.${UPSTREAM_LIBVERSION} $(LDFLAGS)
	ar rs $(NAME).a $^
	ln -s $(NAME).so.${UPSTREAM_LIBVERSION} $(NAME).so
	ln -s $(NAME).so.${UPSTREAM_LIBVERSION} $(NAME).so.5

clean:
	rm -f *.so* *.a *.o

$(OBJECTS): %.o: %.c
	cc $< -o $@ $(CFLAGS) $(CPPFLAGS)