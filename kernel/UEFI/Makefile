uefi:
	gcc main.c                             \
    	  -c                                 \
      	-fno-stack-protector               \
      	-fpic                              \
	    -fshort-wchar                      \
      -mno-red-zone                      \
      -I /path/to/gnu-efi/headers        \
      -I /path/to/gnu-efi/headers/x86_64 \
      -DEFI_FUNCTION_WRAPPER             \
      -o main.o
	ld main.o                         \
     /path/to/crt0-efi-x86_64.o     \
     -nostdlib                      \
     -znocombreloc                  \
     -T /path/to/elf_x86_64_efi.lds \
     -shared                        \
     -Bsymbolic                     \
     -L /path/to/libs               \
     -l:libgnuefi.a                 \
     -l:libefi.a                    \
     -o main.so
	objcopy -j .text                \
          -j .sdata               \
          -j .data                \
          -j .dynamic             \
          -j .dynsym              \
          -j .rel                 \
          -j .rela                \
          -j .reloc               \
          --target=efi-app-x86_64 \
          main.so                 \
          main.efi

# Why is UEFI SO HARD?