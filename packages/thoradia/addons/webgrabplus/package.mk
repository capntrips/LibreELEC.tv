# SPDX-License-Identifier: GPL-2.0-or-later
# Copyright (C) 2016-present Team LibreELEC (https://libreelec.tv)

PKG_NAME="webgrabplus"
PKG_VERSION="2.1.10_beta"
PKG_SHA256="8254e1e9040b978e4549cbfa68234b414cdfcaaf8c9e784b048729445d1dba90"
PKG_REV="109"
PKG_ARCH="any"
PKG_LICENSE="prop."
PKG_SITE="http://www.webgrabplus.com/"
PKG_URL="http://webgrabplus.com/sites/default/files/download/SW/V2.1.10/WebGrabPlus_V2.1.10_beta_install.tar.gz"
PKG_DEPENDS_TARGET="toolchain"
PKG_SECTION="service"
PKG_SHORTDESC="WebGrab+Plus: a multi-site incremental xmltv epg grabber"
PKG_LONGDESC="WebGrab+Plus ($PKG_VERSION) collects tv-program guide data from selected tvguide sites for your favourite channels."
PKG_TOOLCHAIN="manual"

PKG_IS_ADDON="yes"
PKG_ADDON_NAME="WebGrab+Plus"
PKG_ADDON_TYPE="xbmc.service"
PKG_ADDON_REQUIRES="tools.mono:0.0.0"
PKG_MAINTAINER="thoradia"

addon() {
  mkdir -p $ADDON_BUILD/$PKG_ADDON_ID
  cp -r $PKG_BUILD/bin $ADDON_BUILD/$PKG_ADDON_ID
}
