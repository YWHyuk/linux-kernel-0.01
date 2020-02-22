#!/bin/sh
HOST=DEWH
../mk
#cp ../fdisk.img /mnt/c/Users/$HOST/Desktop/fdisk.img
qemu-system-i386 -nographic -fda ../fdisk.img -S -s
