# Based on <https://wiki.debian.org/Multiarch/Tuples>

DEB_HOST_ARCH = $(shell dpkg-architecture --query DEB_HOST_ARCH)
DEB_HOST_ARCH_BITS = $(shell dpkg-architecture --query DEB_HOST_ARCH_BITS)

ifeq ($(DEB_HOST_ARCH), amd64)
  ANDROID_INCLUDES = -include arch/linux-x86/AndroidConfig.h
endif
ifeq ($(DEB_HOST_ARCH), i386)
  ANDROID_INCLUDES = -include arch/linux-x86/AndroidConfig.h
endif

ifeq ($(DEB_HOST_ARCH), arm64)
  ANDROID_INCLUDES = -include arch/linux-arm64/AndroidConfig.h
endif
ifeq ($(DEB_HOST_ARCH), arm)
  ifeq ($(DEB_HOST_ARCH_BITS), 32)
    ANDROID_INCLUDES = -include arch/linux-arm/AndroidConfig.h
  endif
  ifeq ($(DEB_HOST_ARCH_BITS), 64)
    ANDROID_INCLUDES = -include arch/linux-arm64/AndroidConfig.h
  endif
endif
ifeq ($(DEB_HOST_ARCH), armel)
  ifeq ($(DEB_HOST_ARCH_BITS), 32)
    ANDROID_INCLUDES = -include arch/linux-arm/AndroidConfig.h
  endif
  ifeq ($(DEB_HOST_ARCH_BITS), 64)
    ANDROID_INCLUDES = -include arch/linux-arm64/AndroidConfig.h
  endif
endif
ifeq ($(DEB_HOST_ARCH), armhf)
  ifeq ($(DEB_HOST_ARCH_BITS), 32)
    ANDROID_INCLUDES = -include arch/linux-arm/AndroidConfig.h
  endif
  ifeq ($(DEB_HOST_ARCH_BITS), 64)
    ANDROID_INCLUDES = -include arch/linux-arm64/AndroidConfig.h
  endif
endif

ifeq ($(DEB_HOST_ARCH), mipsel)
  ANDROID_INCLUDES = -include arch/linux-mips/AndroidConfig.h
endif
ifeq ($(DEB_HOST_ARCH), mips64el)
  ANDROID_INCLUDES = -include arch/linux-mips64/AndroidConfig.h
endif
ifeq ($(DEB_HOST_ARCH), mips)
  ifeq ($(DEB_HOST_ARCH_BITS), 32)
    ANDROID_INCLUDES = -include arch/linux-mips/AndroidConfig.h
  endif
  ifeq ($(DEB_HOST_ARCH_BITS), 64)
    ANDROID_INCLUDES = -include arch/linux-mips64/AndroidConfig.h
  endif
endif