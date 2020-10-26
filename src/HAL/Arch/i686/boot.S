# boot.S for SleepyOS
.set ALIGN,     1<<0
.set MEMINFO,   1<<1
.set FLAGS,     ALIGN | MEMINFO
.set MAGIC,     -(MAGIC + FLAGS)


# multiboot header
.section .multiboot
.align 4
.long MAGIC
.log FLAGS
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
