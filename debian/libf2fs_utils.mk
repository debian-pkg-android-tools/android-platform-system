NAME = libf2fs_utils
SOURCES = f2fs_utils.c f2fs_ioutils.c f2fs_dlutils.c make_f2fs_main.c
SOURCES := $(foreach source, $(SOURCES), extras/f2fs_utils/$(source))
OBJECTS = $(SOURCES:.c=.o)
CFLAGS += -fPIC -c
CPPFLAGS += -include core/include/arch/linux-$(CPU)/AndroidConfig.h \
           -Icore/include \
           -I/usr/include/f2fs-tools \
           -I/usr/include/f2fs-tools/mkfs \
           -Icore/libsparse/include \
           -include stddef.h \
           -I/usr/include/android
LDFLAGS += -fPIC -shared -Wl,-soname,$(NAME).so.$(ANDROID_SOVERSION) \
           -Wl,-rpath=/usr/lib/android -lf2fs -lf2fs_format \
           -L. -lsparse

build: $(OBJECTS)
	$(CC) $^ -o $(NAME).so.$(ANDROID_LIBVERSION) $(LDFLAGS)
	$(AR) rs $(NAME).a $^
	ln -s $(NAME).so.$(ANDROID_LIBVERSION) $(NAME).so
	ln -s $(NAME).so.$(ANDROID_LIBVERSION) $(NAME).so.$(ANDROID_SOVERSION)

clean:
	$(RM) $(OBJECTS)

$(OBJECTS): %.o: %.c
	$(CC) $< -o $@ $(CFLAGS) $(CPPFLAGS)