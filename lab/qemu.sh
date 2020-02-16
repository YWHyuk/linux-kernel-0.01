#!/bin/sh
HOST=DEWH
#cp ../Image /mnt/c/Users/$HOST/Desktop/Image
qemu-system-i386 -nographic -fda ../Image -S -s
