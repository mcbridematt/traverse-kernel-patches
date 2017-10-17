# Traverse Kernel Build Tool

This is a simple tool to generate a kernel and module set that works on Traverse LS1043 boards, using a patchset that is applied against the Linus kernel tree.
Both native compilation and cross compiling are supported

## How to use
### Cross-compile
```
CROSS_COMPILE=/home/matt/five64-lede-staging/staging_dir/toolchain-aarch64_generic_gcc-5.4.0_musl/bin/aarch64-openwrt-linux- ./build.sh
```
### Native compile
```
./build.sh
```
### Cloning an existing kernel tree
```
KERNEL_GIT=$HOME/linux.git ./build.sh
```
## Build artefacts
```
build/kernel.itb -> a FIT image

build/mods -> modules to copy into /lib/modules/

```
