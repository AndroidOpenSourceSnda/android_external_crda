# Copyright 2010 ST Ericsson

LOCAL_PATH := $(call my-dir)
CRDA_PATH := $(LOCAL_PATH)

PUBKEY_DIR := pubkeys
RUNTIME_PUBKEY_DIR := /etc/wireless-regdb/pubkeys


# Build executable "crda"
include $(CLEAR_VARS)

LOCAL_MODULE := crda
LOCAL_MODULE_TAGS := optional
LOCAL_MODULE_CLASS := EXECUTABLES


LOCAL_SRC_FILES := \
	reglib.c \
	crda.c

LOCAL_C_INCLUDES := \
	external/openssl/include \
	external/netlink/include

LOCAL_CFLAGS := -O2 -g -Wall -DHAVE_CONFIG_H -DUSE_OPENSSL -DCONFIG_LIBNL20 -DPUBKEY_DIR=\"$(RUNTIME_PUBKEY_DIR)\"

LOCAL_SHARED_LIBRARIES := libcrypto libssl libnl

include $(BUILD_EXECUTABLE)


# Build executable "intersect"
include $(CLEAR_VARS)

LOCAL_MODULE := intersect
LOCAL_MODULE_TAGS := optional
LOCAL_MODULE_CLASS := EXECUTABLES

LOCAL_SRC_FILES := \
	reglib.c \
	intersect.c \
	print-regdom.c

LOCAL_C_INCLUDES := \
	external/openssl/include \
	external/netlink/include

LOCAL_CFLAGS := -O2 -g -Wall -DHAVE_CONFIG_H -DUSE_OPENSSL -DCONFIG_LIBNL20 -DPUBKEY_DIR=\"$(RUNTIME_PUBKEY_DIR)\"

LOCAL_SHARED_LIBRARIES := libcrypto libssl libnl

include $(BUILD_EXECUTABLE)


# Build executable "regdbdump"
include $(CLEAR_VARS)

LOCAL_MODULE := regdbdump
LOCAL_MODULE_TAGS := optional
LOCAL_MODULE_CLASS := EXECUTABLES

LOCAL_SRC_FILES := \
	reglib.c \
	regdbdump.c \
	print-regdom.c


LOCAL_C_INCLUDES := \
	external/openssl/include \
	external/netlink/include

LOCAL_CFLAGS := -O2 -g -Wall -DHAVE_CONFIG_H -DUSE_OPENSSL -DCONFIG_LIBNL20 -DPUBKEY_DIR=\"$(RUNTIME_PUBKEY_DIR)\"

LOCAL_SHARED_LIBRARIES := libcrypto libssl libnl

include $(BUILD_EXECUTABLE)


# Copy regulatory.bin to lib directory
include $(CLEAR_VARS)

local_target_dir := $(TARGET_OUT)/lib/crda

LOCAL_MODULE := regulatory.bin
LOCAL_MODULE_TAGS := optional
LOCAL_MODULE_CLASS := SHARED_LIBRARIES
LOCAL_MODULE_PATH := $(local_target_dir)
LOCAL_SRC_FILES := db/$(LOCAL_MODULE)

include $(BUILD_PREBUILT)


# Copy 85-regulatory.rules to etc/udev/rules directory
include $(CLEAR_VARS)

local_target_dir := $(TARGET_OUT_ETC)/udev/rules.d

LOCAL_MODULE := 85-regulatory.rules
LOCAL_MODULE_TAGS := optional
LOCAL_MODULE_CLASS := ETC
LOCAL_MODULE_PATH := $(local_target_dir)
LOCAL_SRC_FILES := udev/regulatory.rules.android

include $(BUILD_PREBUILT)

