NAME = fastboot
SOURCES = protocol.c engine.c bootimg_utils.cpp fastboot.cpp util.c fs.c usb_linux.c util_linux.c
CSOURCES = $(foreach source, $(filter %.c, $(SOURCES)), core/fastboot/$(source))
CXXSOURCES = $(foreach source, $(filter %.cpp, $(SOURCES)), core/fastboot/$(source))
COBJECTS = $(CSOURCES:.c=.o)
CXXOBJECTS = $(CXXSOURCES:.cpp=.o)
CFLAGS += -c -fPIC
CXXFLAGS += -c -fPIC -fpermissive
CPPFLAGS += -DUSE_F2FS -DFASTBOOT_REVISION='"debian"' \
            -include core/include/arch/linux-$(CPU)/AndroidConfig.h \
            -Icore/include \
            -Icore/mkbootimg \
            -Iextras/ext4_utils \
            -Iextras/f2fs_utils \
            -I/usr/include/openssl \
            -Icore/libsparse/include
LDFLAGS += -fPIC -Wl,-rpath=/usr/lib/android -Wl,-rpath-link=. \
           -L. -lziparchive -lext4_utils -lsparse -lf2fs_utils

build: $(COBJECTS) $(CXXOBJECTS)
	$(CC) $^ -o $(NAME) $(LDFLAGS)

clean:
	$(RM) $(NAME) $(COBJECTS) $(CXXOBJECTS)

$(CXXOBJECTS): %.o: %.cpp
	$(CXX) $< -o $@ $(CXXFLAGS) $(CPPFLAGS)

$(COBJECTS): %.o: %.c
	$(CC) $< -o $@ $(CFLAGS) $(CPPFLAGS)