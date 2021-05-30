LOCAL_PATH := $(call my-dir)/gtest/googletest

###########################
#
# GTEST shared library
#
###########################

include $(CLEAR_VARS)

LOCAL_MODULE := gtest

LOCAL_C_INCLUDES := $(LOCAL_PATH) $(LOCAL_PATH)/include

LOCAL_EXPORT_C_INCLUDES := $(LOCAL_C_INCLUDES)

LOCAL_SRC_FILES := $(LOCAL_PATH)/src/gtest-all.cc

include $(BUILD_SHARED_LIBRARY)
