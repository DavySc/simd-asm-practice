%include "x86inc.asm" ;Header file in FFMPEG should take a look later

SECTION .text ;Where the code lives

;static void add_values(uint8_t *src, const uint8_t *src2)  
INIT_XMM sse2  ;128 bit simd registers
cglobal add_values, 3, 3, 2, src, src2, width   ;2 arguments, 2 general purpose registers, 2 xmm registers
    add srcq, widthq
    add src2q, width2q
    neg widthq

.loop
    movu  m0, [srcq+widthq]  
    movu  m1, [src2q+width2q]

    paddb m0, m1 ; packed bytewise add

    movu  [srcq+widthq], m0 ;move to the adress srcq
    add widthq, mmsize
    jl .loop

    RET
