mkdir -p ./iso/boot/grub
cp src/grub.cfg ./iso/boot/grub/grub.cfg

# Copy the kernel...
cp bin/sleepy.bin ./iso/boot/sleepy.bin

# Generate kernel
grub-mkrescue -o sleepy.iso ./iso || exit