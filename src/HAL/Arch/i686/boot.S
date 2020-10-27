# boot.S for SleepyOS
.set ALIGN,    1<<0             # load modules on page boundaries
.set MEMINFO,  1<<1             # memory map
.set FLAGS,    ALIGN | MEMINFO  # multiboot flags
.set MAGIC,    0x1BADB002       # magic number
.set CHECKSUM, -(MAGIC + FLAGS) # header checksum
# multiboot header
.section .multiboot
.align 4
.long MAGIC
.long FLAGS
.long CHECKSUM


# Memory for intial thread
.section .bss
.align 16
stack_bottom:
  .skip 16384 # 16 KiB
stack_top:



.section .text
.global _start
.type _start, @function
_start:
  mov $stack_top, %esp
  cli
  jmp $0x8, $protectedModeMain


protectedModeMain:
  sti
  call kernel_main
  call term_test_post

1:  hlt
    jmp 1b

;
;
;.size _start, . - _start
;
