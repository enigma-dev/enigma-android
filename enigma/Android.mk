ENIGMA_ROOT := $(call my-dir)/../../
ENIGMA_SHELL := $(ENIGMA_ROOT)/ENIGMAsystem/SHELL
EXTERNAL := $(ENIGMA_ROOT)/android/external
WORKDIR := /tmp/ENIGMA

FIX_PATHS := $(shell bash -c "$(ENIGMA_ROOT)/android/fix_paths.sh $(WORKDIR) $(ENIGMA_SHELL) $(ENIGMA_ROOT)")

include $(WORKDIR)/build.makefiles

include $(CLEAR_VARS)

LOCAL_MODULE := enigma

IGNORE_WARNINGS := -Wno-unused-parameter -Wno-ignored-qualifiers  -Wno-dollar-in-identifier-extension

LOCAL_EXPORT_C_INCLUDES := $(LOCAL_C_INCLUDES)
LOCAL_CFLAGS :=  $(shell cat $(WORKDIR)/build.cflags) $(IGNORE_WARNINGS)
LOCAL_CPPFLAGS := -stdlib=libc++ -I$(EXTERNAL)/hacks $(shell cat $(WORKDIR)/build.cxxflags) $(IGNORE_WARNINGS)

LOCAL_SRC_FILES := $(shell cat $(WORKDIR)/sources.list)

LOCAL_SHARED_LIBRARIES := $(shell cat $(WORKDIR)/libs.in)
LOCAL_LDLIBS := $(shell cat $(WORKDIR)/ldlibs.in) -llog -lz
include $(BUILD_SHARED_LIBRARY)
