PKG_NAME="jackett"
PKG_VERSION="0.11.463"
PKG_SHA256="4e8c98704267596d443c315578e952ecb25c163eb828ab0cf18a12470a72d311"
PKG_REV="41"
PKG_LICENSE="GPL2"
PKG_SITE="https://github.com/Jackett/Jackett"
PKG_URL="https://github.com/Jackett/Jackett/releases/download/v$PKG_VERSION/Jackett.Binaries.Mono.tar.gz"
PKG_DEPENDS_TARGET="toolchain"
PKG_SECTION="service"

PKG_IS_ADDON="yes"
PKG_ADDON_NAME="Jackett"
PKG_ADDON_TYPE="xbmc.service"
PKG_ADDON_REQUIRES="tools.mono:0.0.0"
PKG_MAINTAINER="thoradia"
PKG_SHORTDESC="$PKG_ADDON_NAME: proxy to tracker sites"
PKG_LONGDESC="$PKG_ADDON_NAME ($PKG_VERSION) works as a proxy server: it translates queries from applications (CouchPotato, Mylar, SickRage, Sonarr,  etc.) into tracker-site-specific HTTP queries, parses the HTML response, then sends results back to the requesting software. This allows for getting recent uploads (like RSS) and performing searches. Jackett is a single repository of maintained indexer scraping and translation logic, removing the burden from other applications."
PKG_DISCLAIMER="Keep it legal and carry on"

PKG_TOOLCHAIN="manual"

addon() {
  mkdir -p $ADDON_BUILD/$PKG_ADDON_ID/jackett
  cp -PR $PKG_BUILD/* $ADDON_BUILD/$PKG_ADDON_ID/jackett
}
