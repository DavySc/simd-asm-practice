%define private_prefix my     ; or my_ or your own prefix
%define ARCH_X86_64 1
%define HAVE_ALIGNED_STACK 1
%include "x86inc.asm" ;Header file in FFMPEG should take a look later

SECTION .text

cglobal sum_asm, 2, 2, 2, arr, len
; arr = r0, len = r1 
pxor m0, m0

.loop:
  movdqu m1, [r0]
  paddd m0, m1
  add r0, 16
  sub r1d, 4
  jg .loop
movhlps m1, m0     ; copy high 64 bits into low 64 of m1
paddd   m0, m1     ; add [a+b, c+d]
pshufd  m1, m0, 1  ; shuffle element 1 down
paddd   m0, m1     ; final sum in lowest lane
movd    eax, m0    ; move scalar to return register
RET
