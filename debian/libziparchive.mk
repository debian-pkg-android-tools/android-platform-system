include ../../debian/android_includes.mk

NAME = libziparchive
SOURCES = zip_archive.cc
OBJECTS = $(SOURCES:.cc=.o)
INCLUDES = $(ANDROID_INCLUDES) -I../include -I../../libnativehelper/include/nativehelper
LOCAL_CXXFLAGS = -fPIC -c -mno-ms-bitfields
LOCAL_LDFLAGS = -fPIC -shared -rdynamic -Wl,-rpath=/usr/lib/android \
                -Wl,-soname,$(NAME).so.5 -lpthread -lz  \
                -L../libutils -lutils

build: $(OBJECTS)
	cc $^ -o $(NAME).so $(LDFLAGS) $(LOCAL_LDFLAGS)
	ar rs $(NAME).a $^

clean:
	rm -f *.so *.a *.o

$(OBJECTS): %.o: %.cc
	c++ $< -o $@ $(CXXFLAGS) $(CPPFLAGS) $(INCLUDES) $(LOCAL_CXXFLAGS)