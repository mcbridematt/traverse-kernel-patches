#!/usr/bin/env bash
SCRIPTPATH=$(readlink -f "$0")
THISDIR=$(dirname "$SCRIPTPATH")

SDK_DL="https://downloads.lede-project.org/snapshots/targets/armvirt/64/lede-sdk-armvirt-64_gcc-5.5.0_musl.Linux-x86_64.tar.xz"
SDK_FILE="lede-sdk-armvirt-64_gcc-5.5.0_musl.Linux-x86_64.tar.xz"
SDK_DIR=lede-sdk-armvirt-64_gcc-5.5.0_musl.Linux-x86_64

MACHINE=`uname -m`
if [[ "$MACHINE" != "aarch64" ]] && [[ ! -d "/opt/lede-sdk-armvirt-64_gcc-5.5.0_musl.Linux-x86_64" ]] ; then
	echo "This is not a native aarch64 machine, downloading a toolchain"
	wget -c $SDK_DL
	tar -Jxvf $SDK_FILE
	export CROSS_COMPILE=$THISDIR/$SDK_DIR/staging_dir/toolchain-aarch64_generic_gcc-5.5.0_musl/bin/aarch64-openwrt-linux-
	export STAGING_DIR=$THISDIR/$SDK_DIR/staging_dir
elif [[ -d "/opt/lede-sdk-armvirt-64_gcc-5.5.0_musl.Linux-x86_64" ]]; then
	export CROSS_COMPILE=/opt/$SDK_DIR/staging_dir/toolchain-aarch64_generic_gcc-5.5.0_musl/bin/aarch64-openwrt-linux-
	export STAGING_DIR=$CROSS_COMPILE/staging_dir
fi
git config --global user.name "CI Build Bot"
git config --global user.email "devnull@example.com"
set 
GIT_ARGS="--depth 5" ./build.sh
