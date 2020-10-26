#!/bin/bash


mkdir -p iso/boot/grub
cp sleepy.kernel isodir/boot/sleepy.kernel
cp grub.i686.cfg isodir/boot/grub/grub.i686.cfg

grub-mkrescue -o sleepy.iso iso/
