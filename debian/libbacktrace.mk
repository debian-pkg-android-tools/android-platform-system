NAME = libbacktrace
SOURCES = Backtrace.cpp \
          BacktraceCurrent.cpp \
          BacktraceMap.cpp \
          BacktracePtrace.cpp \
          thread_utils.c \
          ThreadEntry.cpp \
          UnwindCurrent.cpp \
          UnwindMap.cpp \
          UnwindPtrace.cpp
CSOURCES = $(foreach source, $(filter %.c, $(SOURCES)), core/libbacktrace/$(source))
CXXSOURCES = $(foreach source, $(filter %.cpp, $(SOURCES)), core/libbacktrace/$(source))
COBJECTS = $(CSOURCES:.c=.o)
CXXOBJECTS = $(CXXSOURCES:.cpp=.o)
CFLAGS += -fPIC -c
CXXFLAGS += -fPIC -c -std=c++11
CPPFLAGS += -include core/include/arch/linux-$(CPU)/AndroidConfig.h \
            -Icore/include -Icore/base/include -I/usr/include/android/unwind
LDFLAGS += -fPIC -shared  -Wl,-soname,$(NAME).so.$(ANDROID_SOVERSION) \
           -Wl,-rpath=/usr/lib/android -lrt -lpthread \
           -L/usr/lib/android -lunwind -L. -lbase -llog -lcutils

build: $(COBJECTS) $(CXXOBJECTS)
	$(CXX) $^ -o $(NAME).so.$(ANDROID_LIBVERSION) $(LDFLAGS)
	$(AR) rs $(NAME).a $^
	ln -s $(NAME).so.$(ANDROID_LIBVERSION) $(NAME).so
	ln -s $(NAME).so.$(ANDROID_LIBVERSION) $(NAME).so.$(ANDROID_SOVERSION)

clean:
	$(RM) $(COBJECTS) $(CXXOBJECTS)

$(CXXOBJECTS): %.o: %.cpp
	$(CXX) $< -o $@ $(CXXFLAGS) $(CPPFLAGS)

$(COBJECTS): %.o: %.c
	$(CC) $< -o $@ $(CFLAGS) $(CPPFLAGS)