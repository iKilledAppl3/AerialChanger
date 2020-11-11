ARCHS = arm64
TARGET = appletv:clang
SYSROOT = $(THEOS)/sdks/AppleTVOS12.4.sdk
FINALPACKAGE = 1
THEOS_DEVICE_IP = 192.168.1.211

include $(THEOS)/makefiles/common.mk

BUNDLE_NAME = AerialChanger
AerialChanger_FILES = $(wildcard *.mm)
AerialChanger_INSTALL_PATH = /Library/PreferenceBundles
AerialChanger_FRAMEWORKS = UIKit TVSettingKit 
AerialChanger_PRIVATE_FRAMEWORKS = TVSettingKit
AerialChanger_CFLAGS+= -I. -ITVSettings -ITVSettingsKit -Wno-error
AerialChanger_LDFLAGS = -undefined dynamic_lookup


include $(THEOS_MAKE_PATH)/bundle.mk

internal-stage::
	$(ECHO_NOTHING)mkdir -p $(THEOS_STAGING_DIR)/Library/PreferenceLoader/Preferences$(ECHO_END)
	$(ECHO_NOTHING)cp entry.plist $(THEOS_STAGING_DIR)/Library/PreferenceLoader/Preferences/AerialChanger.plist$(ECHO_END)
