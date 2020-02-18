#
# Makefile for linux.
# If you don't have '-mstring-insns' in your gcc (and nobody but me has :-)
# remove them from the CFLAGS defines.
#

AS86	=as 
CC86	=cc 
LD86	=ld

AS	=as
LD	=ld
LDFLAGS	=-m elf_i386 -s -x -M
CC	=gcc
CFLAGS	=-Wall -O -m32 -march=i386 -fomit-frame-pointer\
	-fstack-protector-explicit -s -fno-pic
AFLAGS  =--32 -march=i386
CPP	=gcc -E -nostdinc -Iinclude

ARCHIVES=kernel/kernel.o mm/mm.o fs/fs.o
LIBS	=lib/lib.a

.c.s:
	$(CC) $(CFLAGS) \
	-nostdinc -Iinclude -S -o $*.s $<
.s.o:
	$(AS) $(AFLAGS) \
	-c -o $*.o $<
.c.o:
	$(CC) $(CFLAGS) \
	-nostdinc -Iinclude -c -o $*.o $<

all:	Image

Image: boot/boot tools/system 
	cat boot/boot > Image 
	cat tools/system >> Image
	sync

boot/head.o: boot/head.s

tools/system:	boot/head.o init/main.o \
	$(ARCHIVES) $(LIBS)
	$(LD) -T tools/system.ld boot/head.o init/main.o \
	$(ARCHIVES) \
	$(LIBS) \
	-M -o tools/system.elf > System.map
	objcopy -S -O binary tools/system.elf tools/system

kernel/kernel.o:
	(cd kernel; make)

mm/mm.o:
	(cd mm; make)

fs/fs.o:
	(cd fs; make)

lib/lib.a:
	(cd lib; make)

boot/boot:	boot/boot.s tools/system
	stat tools/system --format="SYSSIZE = (%s + 15)/16" > tmp.s
	cat boot/boot.s >> tmp.s
	$(CC) -Wall -m16 -march=i386 -c -o boot/boot.o tmp.s 
	rm -f tmp.s
	$(LD86) -T boot/boot.ld -o boot/boot boot/boot.o

clean:
	rm -f Image System.map tmp_make boot/boot core
	rm -f init/*.o boot/*.o tools/system 
	(cd mm;make clean)
	(cd fs;make clean)
	(cd kernel;make clean)
	(cd lib;make clean)

backup: clean
	(cd .. ; tar cf - linux | compress16 - > backup.Z)
	sync

dep:
	sed '/\#\#\# Dependencies/q' < Makefile > tmp_make
	(for i in init/*.c;do echo -n "init/";$(CPP) -M $$i;done) >> tmp_make
	cp tmp_make Makefile
	(cd fs; make dep)
	(cd kernel; make dep)
	(cd mm; make dep)

### Dependencies:
init/main.o : init/main.c include/unistd.h include/sys/stat.h \
  include/sys/types.h include/sys/times.h include/sys/utsname.h \
  include/utime.h include/time.h include/linux/tty.h include/termios.h \
  include/linux/sched.h include/linux/head.h include/linux/fs.h \
  include/linux/mm.h include/asm/system.h include/asm/io.h include/stddef.h \
  include/stdarg.h include/fcntl.h 
