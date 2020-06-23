#!/bin/bash
#============================================================
# File name: diy-part2.sh
# Description: OpenWrt DIY script part 2 (After Update feeds)
#============================================================

# modify default IP
sed -i 's/192.168.1.1/192.168.5.1/g' package/base-files/files/bin/config_generate

# remove default passwd
sed -i "/CYXluq4wUazHjmCDBCqXF/d" package/lean/default-settings/files/zzz-default-settings

# remove default theme
sed -i '/set luci.main.mediaurlbase=\/luci-static\/bootstrap/d' feeds/luci/themes/luci-theme-bootstrap/root/etc/uci-defaults/30_luci-theme-bootstrap

# remove old argon theme and pull latest argon
pushd package/lean
rm -rf luci-theme-argon
git clone -b 18.06 https://github.com/jerrykuku/luci-theme-argon luci-theme-argon
popd

# luci-app-openclash
git clone -b master https://github.com/vernesong/OpenClash package/diy-packages/openclash
pushd package/diy-packages/openclash/luci-app-openclash/tools/po2lmo
make && sudo make install
popd
