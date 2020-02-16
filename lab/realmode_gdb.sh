#!/bin/sh
#GDB=/mnt/c/cygwin64/bin/gdb.exe
GDB=gdb
$GDB -ix gdbinit_real_mode.txt ../tools/system.elf         -ex 'target remote localhost:1234'         -ex 'break *0x7c00'         -ex 'continue'
