mkdir -p ./iso/boot/grub
mkdir -p ./iso/System/Kernel/
cp grub.cfg ./iso/boot/grub/grub.cfg

# Copy the kernel...
cp ./sleepy.kernel ./iso/System/Kernel/sleepy.kernel

# Generate kernel
grub-mkrescue -o sleepy.iso ./iso