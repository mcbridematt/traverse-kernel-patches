#!/bin/sh
# Traverse Kernel Build Tool
# Author: Mathew McBride <matt@traverse.com.au>

THIS_DIR=`pwd`
MACHINE=`uname -m`
echo "Build machine type: $MACHINE"
CROSS_COMPILE=${CROSS_COMPILE: }
if [ "$MACHINE" != "aarch64" ]; then
	if [ -z "$CROSS_COMPILE" ]; then
		echo "Error: When not building on a native aarch64 machine, CROSS_COMPILE must be defined"
		exit 1
	fi
fi
rm -rf build
if [ -d "linux" ]; then
	echo "WARNING: Linux kernel tree already exists, moving to linux.old"
	rm -rf linux.old
	mv linux linux.old
fi


mkdir build
mkdir -p build/mods/
KERNEL_GIT=${KERNEL_GIT:-git://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git}

git clone $KERNEL_GIT linux
cp kernel-config linux/.config
cd linux
for i in `ls ${THIS_DIR}/patches/`; do
	git am ${THIS_DIR}/patches/$i
done

make oldconfig
make -j`nproc` ARCH=arm64
cp ../kernel.its .
./scripts/dtc/dtc kernel.its -O dtb -o kernel.itb
cp kernel.itb ../build/
make INSTALL_MOD_PATH=${THIS_DIR}/build/mods/ AARCH=arm64 CROSS_COMPILE=${CROSS_COMPILE} modules_install
