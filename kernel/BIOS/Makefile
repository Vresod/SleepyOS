sleep:
	as --32 boot.s -o boot.o
	gcc -m32 -c kernel.c -o kernel.o -std=gnu99 -ffreestanding -O2 -Wall -Wextra
	ld -m elf_i386 -T linker.ld kernel.o boot.o -o sleepyos.bin -nostdlib
	mkdir -p isodir/boot/grub
	cp sleepyos.bin isodir/boot/sleepyos.bin
	cp grub.cfg isodir/boot/grub/grub.cfg
	grub-mkrescue -o sleepyos.iso isodir
	qemu-system-x86_64 -cdrom sleepyos.iso
clean:
	rm -rf isodir
	rm *.bin
	rm *.o
	rm *.iso