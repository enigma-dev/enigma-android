LOCAL_PATH := $(call my-dir)/libpng

###########################
#
# libpng shared library
#
###########################

include $(CLEAR_VARS)

LOCAL_MODULE := libpng

LOCAL_C_INCLUDES := $(LOCAL_PATH)

LOCAL_EXPORT_C_INCLUDES := $(LOCAL_C_INCLUDES)

LOCAL_SRC_FILES := $(wildcard $(LOCAL_PATH)/*.c) $(wildcard $(LOCAL_PATH)/arm/*.c)
LOCAL_LDLIBS := -lz

include $(BUILD_SHARED_LIBRARY)
