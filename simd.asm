%include "x86inc.asm" ;Header file in FFMPEG should take a look later

SECTION .text ;Where the code lives

;static void add_values(uint8_t *src, const uint8_t *src2)  
INIT_XMM sse2  ;128 bit simd registers
cglobal add_values, 2, 2, 2, src, src2   ;2 arguments, 2 general purpose registers, 2 xmm registers
    movu  m0, [srcq]  
    movu  m1, [src2q]

    paddb m0, m1 ; packed bytewise add

    movu  [srcq], m0 ;move to the adress srcq

    RET
