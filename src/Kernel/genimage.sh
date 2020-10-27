#!/bin/bash


mkdir -p ./iso/boot/grub
cp bin/sleepy.bin ./iso/boot/sleepy.bin
cp src/Kernel/grub.cfg ./iso/boot/grub/grub.cfg

grub-mkrescue -o ./sleepy.iso ./iso || exit
