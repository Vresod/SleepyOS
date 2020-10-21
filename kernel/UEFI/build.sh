#!/bin/sh
rm *.EFI
rm *.o
sleep 3
x86_64-w64-mingw32-gcc -ffreestanding -Iinc/ -Iinc/x86_64/ -Iinc/protocol -c -o kernel.o kernel.c
x86_64-w64-mingw32-gcc -ffreestanding -Iinc/ -Iinc/x86_64/ -Iinc/protocol -c -o data.o   data.c
# Compile/Link
x86_64-w64-mingw32-gcc -nostdlib -Wl,-dll -shared -Wl,--subsystem,10 -e efi_main -o BOOTX64.EFI kernel.o data.o -lgcc