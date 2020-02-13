!#/bin/sh
gdb -ix gdbinit_real_mode.txt main.elf         -ex 'target remote localhost:1234'         -ex 'break *0x7c00'         -ex 'continue'
