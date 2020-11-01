.DEFAULT_GOAL := all

MKRESCUE = grub-mkrescue

# ifeq (, $(shell which grub-mkrescue 2>/dev/null))
# 	ifeq (, $(shell which grub2-mkrescue 2>/dev/null))
# 		$(error "No grub-mkrescue or grub2-mkrescue in $(PATH)")
# 	else
#		MKRESCUE = grub2-mkrescue
# 	endif
# endif


ARCH := UNSPECIFIED
ROOT_DIR := $(shell dirname $(realpath $(firstword $(MAKEFILE_LIST))))
BUILD_DIR := $(ROOT_DIR)/bin
SRC_DIR := $(ROOT_DIR)/src
RES_DIR := $(ROOT_DIR)/res
FONTS_DIR := res/fonts
HAL_DIR := $(SRC_DIR)/HardwareAbstractionLayer
HAL_SRC_DIR := $(HAL_DIR)/Architectures/i686
KERNEL_SRC_DIR := $(SRC_DIR)/Kernel
OBJ_DIR := $(BUILD_DIR)/obj
OBJ_DIR_RES := $(OBJ_DIR)/res
OBJ_DIR_HAL := $(OBJ_DIR)/HAL
CC := clang -I$(HAL_SRC_DIR) -I$(HAL_SRC_DIR) -I$(HAL_DIR)/Headers -I$(SRC_DIR)/Utilities -Xclang -fcolor-diagnostics -pipe -D_FILE_OFFSET_BITS=64 -Wall -Winvalid-pch -Wnon-virtual-dtor -g -fPIC --target=i686-pc-none-elf -march=i686 -nostdlib -ffreestanding -O2 -Wall -Wextra -fno-pic -fno-threadsafe-statics -Wl,--build-id=none -Wreturn-type -fpermissive -MD
CXX := clang++ -I$(HAL_SRC_DIR) -I$(HAL_SRC_DIR) -I$(KERNEL_SRC_DIR) -I$(HAL_DIR)/Headers -I$(SRC_DIR)/Utilities -Xclang -fcolor-diagnostics -pipe -D_FILE_OFFSET_BITS=64 -Wall -Winvalid-pch -Wnon-virtual-dtor -g -fPIC --target=i686-pc-none-elf -march=i686 -nostdlib -ffreestanding -O2 -Wall -Wextra -fno-pic -fno-threadsafe-statics -Wl,--build-id=none -Wreturn-type -fpermissive -MD
ASM := nasm -f elf
STATIC_LINK := llvm-ar
OBJCOPY := objcopy -O elf32-i386 -B i386 -I binary
CXX_LINK := clang++ -o -Wl,--as-needed -Wl,--no-undefined --target=i686-pc-none-elf -march=i686 -nostdlib -ffreestanding -O2 -Wall -Wextra -fno-pic -fno-threadsafe-statics -Wl,--build-id=none -Wreturn-type -fpermissive
IMAGE_GEN := $(KERNEL_SRC_DIR)/gen_image.sh
GRUB_CFG := $(KERNEL_SRC_DIR)/grub.cfg

export MKRESCUE
export GCC
export BUILD_DIR

bin: clean
	mkdir -p $(BUILD_DIR)
	mkdir -p $(OBJ_DIR)
	mkdir -p $(OBJ_DIR_HAL)
	mkdir -p $(OBJ_DIR_RES)
	$(CC)  -MF$(OBJ_DIR_HAL)/boot.s.o.d -o $(OBJ_DIR_HAL)/boot.s.o -c src/boot.s
	$(CXX) -MF$(OBJ_DIR_HAL)/Terminal.cpp.o.d -o $(OBJ_DIR_HAL)/Terminal.cpp.o -c src/header/terminal.cpp
	$(CXX) -MF$(OBJ_DIR_HAL)/Kernel.cpp.o.d -o $(OBJ_DIR)/Kernel.cpp.o -c src/kernel.cpp -DARCH=\"$(ARCH)\"
	$(CXX_LINK) -o $(BUILD_DIR)/microCORE.kernel $(OBJ_DIR)/Kernel.cpp.o $(OBJ_DIR_HAL)/boot.s.o $(OBJ_DIR_HAL)/Terminal.cpp.o -T $(HAL_SRC_DIR)/Linker.ld

image: bin
	$(IMAGE_GEN) $(GRUB_CFG) $(BUILD_DIR)/sleepy.bin $(MKRESCUE)

qemu:
	$(MAKE) image ARCH=i686
	qemu-system-x86_64 -cdrom sleepy.iso -m 512M
	
clean:
	rm -rfv $(BUILD_DIR) iso

all: image