include ../../debian/android_includes.mk

NAME = libbacktrace
SOURCES = BacktraceImpl.cpp \
          BacktraceMap.cpp \
          BacktraceThread.cpp \
          UnwindCurrent.cpp \
          UnwindMap.cpp \
          UnwindPtrace.cpp
OBJECTS = $(SOURCES:.cpp=.o)
CFLAGS += -fPIC -c -std=gnu99
CXXFLAGS += -fPIC -c -std=gnu++11
CPPFLAGS += $(ANDROID_INCLUDES) -I../include -I/usr/include/android/unwind
LDFLAGS += -fPIC -shared -rdynamic -Wl,-rpath=/usr/lib/android \
           -Wl,-soname,$(NAME).so.5 -lrt -lpthread \
           -L../liblog -llog \
           -L../libcutils -lcutils \
           -L/usr/lib/android -lunwind -lunwind-ptrace

build: $(OBJECTS) thread_utils.o
	c++ $^ -o $(NAME).so.${UPSTREAM_LIBVERSION} $(LDFLAGS)
	ar rs $(NAME).a $^
	ln -s $(NAME).so.${UPSTREAM_LIBVERSION} $(NAME).so
	ln -s $(NAME).so.${UPSTREAM_LIBVERSION} $(NAME).so.5

clean:
	rm -f *.so* *.a *.o

$(OBJECTS): %.o: %.cpp
	c++ $< -o $@ $(CXXFLAGS) $(CPPFLAGS)

thread_utils.o: thread_utils.c
	cc $^ -o $@ $(CFLAGS) $(CPPFLAGS)