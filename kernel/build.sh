#!/bin/sh
rm *.EFI
rm *.o
rm -rf iso/
rm *.img
rm *.iso
sleep 3
x86_64-w64-mingw32-gcc -ffreestanding -Iinc/ -Iinc/x86_64/ -Iinc/protocol -c -o kernel.o kernel.c
x86_64-w64-mingw32-gcc -ffreestanding -Iinc/ -Iinc/x86_64/ -Iinc/protocol -c -o data.o   data.c
# Compile/Link
x86_64-w64-mingw32-gcc -nostdlib -Wl,-dll -shared -Wl,--subsystem,10 -e efi_main -o BOOTX64.EFI kernel.o data.o -lgcc

# make that fat image
dd if=/dev/zero of=fat.img bs=1k count=1440
mformat -i fat.img -f 1440 ::
mmd -i fat.img ::/EFI
mmd -i fat.img ::/EFI/BOOT
mcopy -i fat.img BOOTX64.EFI ::/EFI/BOOT

# final step!
mkdir iso
cp fat.img iso
xorriso -as mkisofs -R -f -e fat.img -no-emul-boot -o sleepy.iso iso

qemu-system-x86_64 -L /usr/share/ovmf/ -bios /usr/share/edk2-ovmf/x64/OVMF.fd -cdrom sleepy.iso
