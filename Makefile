.DEFAULT_GOAL := all

MKRESCUE = grub-mkrescue

# Architecture
ARCH := UNSPECIFIED

# Directories
ROOT_DIR := $(shell dirname $(realpath $(firstword $(MAKEFILE_LIST))))
BUILD_DIR	:=	$(ROOT_DIR)/bin
SRC_DIR	:=	$(ROOT_DIR)/src
HAL_DIR	:=	$(SRC_DIR)/HAL
HAL_SRC_DIR	:=	$(HAL_DIR)/Arch/i686
KERNEL_SRC_DIR	:=	$(SRC_DIR)/Kernel
OBJ_DIR := $(BUILD_DIR)/obj
OBJ_DIR_RES := $(OBJ_DIR)/res
OBJ_DIR_HAL := $(OBJ_DIR)/hal


# compile args
CC := clang -I$(HAL_SRC_DIR) -I$(HAL_SRC_DIR) -I$(HAL_DIR)/Headers -I$(SRC_DIR)/Utilities -Xclang -fcolor-diagnostics -pipe -D_FILE_OFFSET_BITS=64 -Wall -Winvalid-pch -Wnon-virtual-dtor -g -fPIC --target=i686-pc-none-elf -march=i686 -nostdlib -ffreestanding -O2 -Wall -Wextra -fno-pic -fno-threadsafe-statics -Wl,--build-id=none -Wreturn-type -fpermissive -MD
CXX := clang++ -I$(HAL_SRC_DIR) -I$(HAL_SRC_DIR) -I$(KERNEL_SRC_DIR) -I$(HAL_DIR)/Headers -I$(SRC_DIR)/Utilities -Xclang -fcolor-diagnostics -pipe -D_FILE_OFFSET_BITS=64 -Wall -Winvalid-pch -Wnon-virtual-dtor -g -fPIC --target=i686-pc-none-elf -march=i686 -nostdlib -ffreestanding -O2 -Wall -Wextra -fno-pic -fno-threadsafe-statics -Wl,--build-id=none -Wreturn-type -fpermissive -MD
ASM := nasm -f elf
STATIC_LINK := llvm-ar
OBJCOPY := objcopy -O elf32-i386 -B i386 -I binary
CXX_LINK := clang++ -o -Wl,--as-needed -Wl,--no-undefined --target=i686-pc-none-elf -march=i686 -nostdlib -ffreestanding -O2 -Wall -Wextra -fno-pic -fno-threadsafe-statics -Wl,--build-id=none -Wreturn-type -fpermissive
IMAGE_GEN := $(KERNEL_SRC_DIR)/genimage.sh
GRUB_CFG := $(KERNEL_SRC_DIR)/grub.i686.cfg


# export
export MKRESCUE
export GCC
export BUILD_DIR

# Targets

bin: clean
	mkdir -p $(BUILD_DIR)
	mkdir -p $(OBJ_DIR)
	mkdir -p $(OBJ_DIR_HAL)
	mkdir -p $(OBJ_DIR_RES)

	# C O O M P I L E
	
	# A S S E M B L Y
	$(CC)  -MF$(OBJ_DIR_HAL)/boot.S.o.d -o $(OBJ_DIR_HAL)/boot.S.o -c $(HAL_SRC_DIR)/boot.S
	# Add stuff as needed btw
	

	# S E E P L U S P L U S
	$(CXX) -MF$(OBJ_DIR_HAL)/Kernel.cpp.o.d -o $(OBJ_DIR)/Kernel.cpp.o -c -DARCH=\"$(ARCH)\"
	$(CXX) -MF$(OBJ_DIR_HAL)/Kernel.cpp.o.d -o $(OBJ_DIR)/Kernel.cpp.o -c $(KERNEL_SRC_DIR)/Kernel.cpp -DARCH=\"$(ARCH)\"
	$(CXX) -MF$(OBJ_DIR_HAL)/terminal.cpp.o.d -o $(OBJ_DIR_HAL)/terminal.cpp.o -c $(HAL_SRC_DIR)/HALFunctions/terminal.cpp
	$(CXX) -MF$(OBJ_DIR_HAL)/terminal.cpp.o.d -o $(OBJ_DIR_HAL)/terminal.cpp.o -c $(HAL_SRC_DIR)/HALFunctions/terminal.cpp

	# BUG FIX (ISSUE #2)
	$(CXX_LINK) -o $(BUILD_DIR)/sleepy.bin $(OBJ_DIR_HAL)/boot.S.o $(OBJ_DIR)/Kernel.cpp.o $(OBJ_DIR_HAL)/terminal.cpp.o

image: bin # Requires bin target
	$(IMAGE_GEN) $(GRUB-CFG) $(BUILD_DIR)/sleepy.bin $(MKRESCUE)

qemu:
	$(MAKE) image ARCH=i686
	qemu-system-x86_64 -cdrom sleepy.iso -m 512M

clean:
	rm -rfv $(BUILD_DIR)
	rm -rf sleepy.iso iso

all: image




