# SPDX-License-Identifier: GPL-2.0-or-later
# Copyright (C) 2016-present Team LibreELEC (https://libreelec.tv)

PKG_NAME="kernel-firmware"
PKG_VERSION="813fa1fc6fba6638decd974c4a6a2e485069ea15"
PKG_SHA256="858d47aec69a972d80724879b90269933777261d511e659cf113947af85242c9"
PKG_LICENSE="other"
PKG_SITE="https://git.kernel.org/pub/scm/linux/kernel/git/firmware/linux-firmware.git/"
PKG_URL="https://git.kernel.org/pub/scm/linux/kernel/git/firmware/linux-firmware.git/snapshot/$PKG_VERSION.tar.gz"
PKG_NEED_UNPACK="${PROJECT_DIR}/${PROJECT}/packages/${PKG_NAME} ${PROJECT_DIR}/${PROJECT}/devices/${DEVICE}/packages/${PKG_NAME}"
PKG_DEPENDS_TARGET="toolchain"
PKG_LONGDESC="kernel-firmware: kernel related firmware"
PKG_TOOLCHAIN="manual"

# Install additional miscellaneous drivers
makeinstall_target() {
  FW_TARGET_DIR=$INSTALL/$(get_full_firmware_dir)

  if find_file_path firmwares/kernel-firmware.dat; then
    FW_LISTS="${FOUND_PATH}"
  else
    FW_LISTS="${PKG_DIR}/firmwares/any.dat ${PKG_DIR}/firmwares/${TARGET_ARCH}.dat"
  fi

  for fwlist in ${FW_LISTS}; do
    [ -f ${fwlist} ] || continue
    while read -r fwline; do
      [ -z "${fwline}" ] && continue
      [[ ${fwline} =~ ^#.* ]] && continue
      [[ ${fwline} =~ ^[[:space:]] ]] && continue

      for fwfile in $(cd ${PKG_BUILD} && eval "find ${fwline}"); do
        [ -d ${PKG_BUILD}/${fwfile} ] && continue

        if [ -f ${PKG_BUILD}/${fwfile} ]; then
          mkdir -p $(dirname ${FW_TARGET_DIR}/${fwfile})
            cp -Lv ${PKG_BUILD}/${fwfile} ${FW_TARGET_DIR}/${fwfile}
        else
          echo "ERROR: Firmware file ${fwfile} does not exist - aborting"
          exit 1
        fi
      done
    done < ${fwlist}
  done

  # The following files are RPi specific and installed by brcmfmac_sdio-firmware-rpi instead.
  # They are also not required at all if the kernel is not suitably configured.
  if listcontains "${FIRMWARE}" "brcmfmac_sdio-firmware-rpi" || \
     ! grep -q "^CONFIG_BRCMFMAC_SDIO=y" $(kernel_config_path); then
    rm -fr $FW_TARGET_DIR/brcm/brcmfmac43430*-sdio.*
    rm -fr $FW_TARGET_DIR/brcm/brcmfmac43455*-sdio.*
  fi

  # brcm pcie firmware is only needed by x86_64
  [ "$TARGET_ARCH" != "x86_64" ] && rm -fr $FW_TARGET_DIR/brcm/*-pcie.*

  # Cleanup - which may be project or device specific
  find_file_path scripts/cleanup.sh && ${FOUND_PATH} ${FW_TARGET_DIR} || true
}
