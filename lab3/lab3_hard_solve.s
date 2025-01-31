.text
.global _main
.align 2


_main:
    adrp x0, list1@PAGE
    add x0, x0, list1@PAGEOFF

    adrp x1, data_compare@PAGE
    add x1, x1, data_compare@PAGEOFF

    bl __ZN4hard4var41C6accessERKNS0_1SE
    
    bl _exit


__ZN4hard4var41C6accessERKNS0_1SE:
    sub    sp, sp, 0x30
    stp    x29, x30, [sp, 0x20]
    add    x29, sp, 0x20
    stur    x0, [x29, -0x8]
    str    x1, [sp, 0x10]
    ldur    x9, [x29, -0x8]
    str    x9, [sp]
    ldr    x8, [sp, 0x10]
    ldr    w8, [x8, 0x4]
    ldrsh    w10, [x9]
    lsl    w8, w8, w10
    ldrsh    w9, [x9, 0x2]
    add    w8, w8, w9
    scvtf    s0, w8
    ldr    x8, [sp, 0x10]
    ldr    s1, [x8]
    mov    w8, 0x0
    fcmp    s0, s1
    str    w8, [sp, 0xc]
    b.hi    _metka1
    ldr    x8, [sp]
    ldrh    w8, [x8, 0x4]
    subs    w8, w8, 0x0
    cset    w8, ne
    str    w8, [sp, 0xc]

_metka1:
    ldr    w8, [sp, 0xc]
    and    w0, w8, 0x1
    bl    __ZN4hardL5checkEb
    ldp    x29, x30, [sp, 0x20]
    add    sp, sp, 0x30
    ret



__ZN4hardL5checkEb:
    sub    sp, sp, 0x20
    stp    x29, x30, [sp, 0x10]
    add    x29, sp, 0x10
    mov    w8, 0x1
    and    w8, w0, w8
    sturb    w8, [x29, -0x1]
    ldurb    w8, [x29, -0x1]
    tbz    w8, 0x0, _metka_check1
    adrp    x1, l_.str.1@PAGE
    add    x1, x1, l_.str.1@PAGEOFF
    mov    x2, l_.str.1_len
    bl    _puts

    b    _metka_check2

_metka_check1:
    adrp   x1, l_.str.2@PAGE
    add    x1, x1, l_.str.2@PAGEOFF
    mov    x2, l_.str.2_len

    bl    _puts
    mov    w0, -0x1
    bl    _exit

_metka_check2:
    ldp    x29, x30, [sp, 0x10]
    add    sp, sp, 0x20
    ret






_puts:
    mov x0, 1
    mov x16, 4
    svc 0
    ret


_exit:
    mov x0, 0
    mov x16, 1
    svc 0
    ret



.data
list1:
    .word 50
    .short 3

data_compare:
    .single 75.0



l_.str.1: .asciz "Access granted\n"
.equ l_.str.1_len , . - l_.str.1


l_.str.2: .asciz "wrong\n"
.equ l_.str.2_len , . - l_.str.2

