## Sleepy OS
A fully hand written operating system designed for the
x86 architecture with just EFI support.


## Questions


### What is this?
Kernel written in near pure C (`.h` files are NOT C++). You can flash it on real hardware or use a virtual machine.

### What's this based off of?
Nothing. If you count OSDev's barebones (UEFI) as being "based",
then yes, it is based off of that.


### How do I flash it on real hardware?
```
dd if=sleepyos of=[device] bs=4M
```

Then, restart the computer.

## Credits
rizet             -- most of his code
osdev IRC channel -- helping me get grub working
