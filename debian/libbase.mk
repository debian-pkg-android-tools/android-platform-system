NAME = libbase
SOURCES = file.cpp \
          stringprintf.cpp \
          strings.cpp
SOURCES := $(foreach source, $(SOURCES), core/base/$(source))
OBJECTS = $(SOURCES:.cpp=.o)
CXXFLAGS += -fPIC -c -std=gnu++11
CPPFLAGS += -include core/include/arch/linux-$(CPU)/AndroidConfig.h -Icore/include -Icore/base/include
LDFLAGS += -fPIC -shared -Wl,-soname,$(NAME).so.$(ANDROID_SOVERSION) \
           -Wl,-rpath=/usr/lib/android -L. -llog

build: $(OBJECTS)
	$(CXX) $^ -o $(NAME).so.$(ANDROID_LIBVERSION) $(LDFLAGS)
	$(AR) rs $(NAME).a $^
	ln -s $(NAME).so.$(ANDROID_LIBVERSION) $(NAME).so
	ln -s $(NAME).so.$(ANDROID_LIBVERSION) $(NAME).so.$(ANDROID_SOVERSION)

clean:
	$(RM) $(OBJECTS)

$(OBJECTS): %.o: %.cpp
	$(CXX) $< -o $@ $(CXXFLAGS) $(CPPFLAGS)