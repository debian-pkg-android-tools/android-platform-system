include ../../debian/android_includes.mk

NAME = libutils
SOURCES = BasicHashtable.cpp \
          BlobCache.cpp \
          CallStack.cpp \
          FileMap.cpp \
          JenkinsHash.cpp \
          LinearAllocator.cpp \
          LinearTransform.cpp \
          Log.cpp \
          NativeHandle.cpp \
          Printer.cpp \
          ProcessCallStack.cpp \
          PropertyMap.cpp \
          RefBase.cpp \
          SharedBuffer.cpp \
          Static.cpp \
          StopWatch.cpp \
          String8.cpp \
          String16.cpp \
          SystemClock.cpp \
          Threads.cpp \
          Timers.cpp \
          Tokenizer.cpp \
          Unicode.cpp \
          VectorImpl.cpp \
          misc.cpp \
          Looper.cpp
OBJECTS = $(SOURCES:.cpp=.o)
INCLUDES = $(ANDROID_INCLUDES) -I../include
LOCAL_CXXFLAGS = -fPIC -c -DLIBUTILS_NATIVE=1
LOCAL_LDFLAGS = -fPIC -shared -rdynamic -Wl,-rpath=/usr/lib/android \
                -Wl,-soname,$(NAME).so.5 -lpthread -lrt -ldl \
                -L../liblog -llog \
                -L/usr/lib/android -lnativehelper

build: $(OBJECTS)
	cc $^ -o $(NAME).so $(LDFLAGS) $(LOCAL_LDFLAGS)
	ar rs $(NAME).a $^

clean:
	rm -f *.so *.a *.o

$(OBJECTS): %.o: %.cpp
	c++ $< -o $@ $(CXXFLAGS) $(CPPFLAGS) $(INCLUDES) $(LOCAL_CXXFLAGS)