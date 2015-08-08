include ../debian/android_includes.mk

NAME = libnativehelper
SOURCES = JNIHelp.cpp JniConstants.cpp toStringArray.cpp JniInvocation.cpp
OBJECTS = $(SOURCES:.cpp=.o)
CXXFLAGS += -fPIC -c -fvisibility=protected
CPPFLAGS += $(ANDROID_INCLUDES) -I../core/include -Iinclude/nativehelper
LDFLAGS += -fPIC -shared -rdynamic -Wl,-rpath=/usr/lib/android \
           -Wl,-soname,$(NAME).so.5 -ldl -L../core/liblog -llog

build: $(OBJECTS)
	c++ $^ -o $(NAME).so.${UPSTREAM_LIBVERSION} $(LDFLAGS)
	ar rs $(NAME).a $^
	ln -s $(NAME).so.${UPSTREAM_LIBVERSION} $(NAME).so
	ln -s $(NAME).so.${UPSTREAM_LIBVERSION} $(NAME).so.5

clean:
	rm -f *.so* *.a *.o

$(OBJECTS): %.o: %.cpp
	c++ $< -o $@ $(CXXFLAGS) $(CPPFLAGS)