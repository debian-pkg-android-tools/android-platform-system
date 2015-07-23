include ../debian/android_includes.mk

NAME = libnativehelper
SOURCES = JNIHelp.cpp JniConstants.cpp toStringArray.cpp JniInvocation.cpp
OBJECTS = $(SOURCES:.cpp=.o)
INCLUDES = $(ANDROID_INCLUDES) -I../core/include -Iinclude/nativehelper
LOCAL_CXXFLAGS = -fPIC -c -fvisibility=protected
LOCAL_LDFLAGS = -fPIC -shared -rdynamic -Wl,-rpath=/usr/lib/android \
                -Wl,-soname,$(NAME).so.5 -lpthread -ldl \
                -L../core/liblog -llog

build: $(OBJECTS)
	cc $^ -o $(NAME).so $(LDFLAGS) $(LOCAL_LDFLAGS)
	ar rs $(NAME).a $^

clean:
	rm -f *.so *.a *.o

$(OBJECTS): %.o: %.cpp
	c++ $< -o $@ $(CXXFLAGS) $(CPPFLAGS) $(INCLUDES) $(LOCAL_CXXFLAGS)