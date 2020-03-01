#!/bin/sh
HOST=DEWH

#cp ../fdisk.img /mnt/c/Users/$HOST/Desktop/fdisk.img
#sudo /mnt/c/'Program Files'/qemu/qemu-system-i386.exe -fda /mnt/c/Users/$HOST/Desktop/fdisk.img
qemu-system-i386 -nographic -fda ../fdisk.img #-S -s  
