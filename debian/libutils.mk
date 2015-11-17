NAME = libutils
SOURCES = BasicHashtable.cpp \
          CallStack.cpp \
          FileMap.cpp \
          JenkinsHash.cpp \
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
SOURCES := $(foreach source, $(SOURCES), core/libutils/$(source))
OBJECTS = $(SOURCES:.cpp=.o)
CXXFLAGS += -fPIC -c -std=gnu++11
CPPFLAGS += -include core/include/arch/linux-$(CPU)/AndroidConfig.h \
            -Icore/include -Idebian -Ilibnativehelper/include/nativehelper \
            -DLIBUTILS_NATIVE=1
LDFLAGS += -fPIC -shared -Wl,-soname,$(NAME).so.$(ANDROID_SOVERSION) \
           -Wl,-rpath=/usr/lib/android \
           -lpthread -L. -llog -lcutils -lbacktrace

build: $(OBJECTS)
	$(CXX) $(OBJECTS) -o $(NAME).so.$(ANDROID_LIBVERSION) $(LDFLAGS)
	$(AR) rs $(NAME).a $(OBJECTS)
	ln -s $(NAME).so.$(ANDROID_LIBVERSION) $(NAME).so
	ln -s $(NAME).so.$(ANDROID_LIBVERSION) $(NAME).so.$(ANDROID_SOVERSION)

clean:
	$(RM) $(OBJECTS)

$(OBJECTS): %.o: %.cpp
	$(CXX) $< -o $@ $(CXXFLAGS) $(CPPFLAGS)