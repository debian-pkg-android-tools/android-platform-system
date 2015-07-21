ifeq ($(shell uname -m), x86_64)
  ANDROID_INCLUDES = -include ../../core/include/arch/linux-x86/AndroidConfig.h
endif
ifeq ($(shell uname -m), amd64)
  ANDROID_INCLUDES = -include ../../core/include/arch/linux-x86/AndroidConfig.h
endif
ifeq ($(shell uname -m), i386)
  ANDROID_INCLUDES = -include ../../core/include/arch/linux-x86/AndroidConfig.h
endif
ifeq ($(shell uname -m), i486)
  ANDROID_INCLUDES = -include ../../core/include/arch/linux-x86/AndroidConfig.h
endif
ifeq ($(shell uname -m), i586)
  ANDROID_INCLUDES = -include ../../core/include/arch/linux-x86/AndroidConfig.h
endif
ifeq ($(shell uname -m), i686)
  ANDROID_INCLUDES = -include ../../core/include/arch/linux-x86/AndroidConfig.h
endif
ifeq ($(shell uname -m), armel)
  ANDROID_INCLUDES = -include ../../core/include/arch/linux-arm/AndroidConfig.h
endif
ifeq ($(shell uname -m), armhf)
  ANDROID_INCLUDES = -include ../../core/include/arch/linux-arm/AndroidConfig.h
endif
ifeq ($(shell uname -m), arm64)
  ANDROID_INCLUDES = -include ../../core/include/arch/linux-arm64/AndroidConfig.h
endif
ifeq ($(shell uname -m), mips)
  ANDROID_INCLUDES = -include ../../core/include/arch/linux-mips/AndroidConfig.h
endif
ifeq ($(shell uname -m), mipsel)
  ANDROID_INCLUDES = -include ../../core/include/arch/linux-mips/AndroidConfig.h
endif