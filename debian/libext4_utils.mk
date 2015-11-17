NAME = libext4_utils
SOURCES = make_ext4fs.c \
          ext4fixup.c \
          ext4_utils.c \
          allocate.c \
          contents.c \
          extent.c \
          indirect.c \
          sha1.c \
          wipe.c \
          crc16.c \
          ext4_sb.c
SOURCES := $(foreach source, $(SOURCES), extras/ext4_utils/$(source))
OBJECTS = $(SOURCES:.c=.o)
CFLAGS += -fPIC -c
CPPFLAGS += -include core/include/arch/linux-$(CPU)/AndroidConfig.h \
            -Icore/include \
            -Icore/libsparse/include \
            -I/usr/include/android
LDFLAGS += -fPIC -shared -Wl,-soname,$(NAME).so.$(ANDROID_SOVERSION) \
           -Wl,-rpath=/usr/lib/android -L. -lsparse -L/usr/lib/android -lselinux

build: $(OBJECTS)
	$(CC) $^ -o $(NAME).so.$(ANDROID_LIBVERSION) $(LDFLAGS)
	$(AR) rs $(NAME).a $^
	ln -s $(NAME).so.$(ANDROID_LIBVERSION) $(NAME).so
	ln -s $(NAME).so.$(ANDROID_LIBVERSION) $(NAME).so.$(ANDROID_SOVERSION)

clean:
	$(RM) $(OBJECTS)

$(OBJECTS): %.o: %.c
	$(CC) $< -o $@ $(CFLAGS) $(CPPFLAGS)