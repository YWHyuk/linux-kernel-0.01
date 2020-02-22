gdb -ex 'display/10i $pc' -ex 'target remote:1234' -ex 'break *0x00' -ex 'continue'
