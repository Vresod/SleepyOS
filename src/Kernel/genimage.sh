#!/bin/bash


mkdir -p iso/boot/grub
cp bin/sleepy.kernel src/Kernel/isodir/boot/sleepy.kernel
cp src/Kernel/grub.i686.cfg src/Kernel/isodir/boot/grub/grub.i686.cfg

grub-mkrescue -o sleepy.iso iso/
