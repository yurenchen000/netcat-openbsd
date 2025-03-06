
include $(TOPDIR)/rules.mk

PKG_NAME:=netcat-openbsd
#PKG_VERSION:=1.217
#PKG_VERSION:=1.228-1
PKG_VERSION:=1.228
PKG_RELEASE:=1

PKG_SOURCE:=$(PKG_NAME)-$(PKG_VERSION).tar.gz
#PKG_SOURCE_URL:=https://ftp.openbsd.org/pub/OpenBSD/OpenBSD/7.3/src.tar.gz

PKG_SOURCE_URL:=https://salsa.debian.org/debian/netcat-openbsd.git
PKG_SOURCE_PROTO:=git
PKG_SOURCE_VERSION:=debian/1.228-1

PKG_HASH:=skip
PKG_BUILD_DIR:=$(BUILD_DIR)/$(PKG_NAME)-$(PKG_VERSION)

PKG_MAINTAINER:=chen test
PKG_LICENSE:=BSD-3-Clause
PKG_LICENSE_FILES:=COPYING


include $(INCLUDE_DIR)/package.mk

define Package/netcat-openbsd
  SECTION:=net
  CATEGORY:=Network
  TITLE:=Netcat OpenBSD variant
  DEPENDS:=+libbsd
  URL:=https://ftp.openbsd.org/pub/OpenBSD/OpenBSD/7.3/src.tar.gz
endef

define Package/netcat-openbsd/description
  Netcat (nc) is a simple Unix utility which reads and writes data across network
  connections, using TCP or UDP protocol. This is the OpenBSD variant of netcat.
endef

define Build/Configure
	$(call Build/Configure/Default, \
		--disable-rpath \
		--with-included-getopt \
	)
endef


TARGET_CFLAGS += '-DDEBIAN_VERSION=\"$(PKG_VERSION)-$(PKG_RELEASE)chen0\"'
#TARGET_CFLAGS += '-DDEBIAN_VERSION=\"1.228-1chen1\"'
#EXTRA_CFLAGS += '-DDEBIAN_VERSION=\"1.228-1chen2\"'

#define Build/Compile
#  $(MAKE) -C $(PKG_BUILD_DIR)/usr.bin/nc \
#    CC="$(TARGET_CC)" \
#    CFLAGS="$(TARGET_CFLAGS)" \
#    LDFLAGS="$(TARGET_LDFLAGS)"
#endef

define Package/netcat-openbsd/install
	$(INSTALL_DIR) $(1)/usr/bin
	$(INSTALL_BIN) $(PKG_BUILD_DIR)/nc $(1)/usr/bin/nc.openbsd
endef

#echo $(call BuildPackage,netcat-openbsd)
$(eval $(call BuildPackage,netcat-openbsd))
