include ../../debian/android_includes.mk

NAME = libziparchive
SOURCES = zip_archive.cc
OBJECTS = $(SOURCES:.cc=.o)
CXXFLAGS += -fPIC -c -mno-ms-bitfields
CPPFLAGS += $(ANDROID_INCLUDES) -I../include -I../../libnativehelper/include/nativehelper
LDFLAGS += -fPIC -shared -rdynamic -Wl,-rpath=/usr/lib/android \
           -Wl,-soname,$(NAME).so.5 -lz -L../libutils -lutils -L../liblog -llog

build: $(OBJECTS)
	cc $^ -o $(NAME).so $(LDFLAGS)
	ar rs $(NAME).a $^

clean:
	rm -f *.so *.a *.o

$(OBJECTS): %.o: %.cc
	c++ $< -o $@ $(CXXFLAGS) $(CPPFLAGS)