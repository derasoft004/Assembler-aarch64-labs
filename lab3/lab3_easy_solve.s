.text
.global _main
.align 2


_main:
    mov w0, 0
    mov w1, 0
    mov w2, 0
    mov w3, 1

    bl _access4
    
    bl _exit


_access4:
    mov x10, lr

    sub    sp, sp, 0x20
    stp    x29, x30, [sp, 0x10]
    add    x29, sp, 0x10
    sturh    w0, [x29, -0x2]
    sturh    w1, [x29, -0x4]
    sturh    w2, [x29, -0x6]
    str    w3, [sp, 0x4]
    ldursh    w9, [x29, -0x2]
    ldursh    w8, [x29, -0x4]
    orr    w8, w8, w9, lsl 16
    ldr    w9, [sp, 0x4]
    subs    w8, w8, w9
    cset    w8, lt
    and    w0, w8, 0x1
    bl    __ZL5checkb
    ldp    x29, x30, [sp, 0x10]
    add    sp, sp, 0x20
    br x10
    ret


__ZL5checkb:
    sub    sp, sp, 0x20
    stp    x29, x30, [sp, 0x10]
    add    x29, sp, 0x10
    mov    w8, 0x1
    and    w8, w0, w8
    sturb    w8, [x29, -0x1]
    ldurb    w8, [x29, -0x1]
    tbz    w8, 0x0, _metka1
    adrp    x1, l_.str@PAGE
    add    x1, x1, l_.str@PAGEOFF
    mov x2, l_.str_len
    
    bl    _puts
    b    _metka2
_metka1:
    adrp    x1, l_.str.1@PAGE
    add    x1, x1, l_.str.1@PAGEOFF
    mov x2, l_.str.1_len
    bl    _puts
    mov    w0, -0x1
    bl    _exit

_metka2:
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
l_.str:
    .asciz "Access granted\n"
.equ l_.str_len , . - l_.str

l_.str.1:
    .asciz "wrong\n"
.equ l_.str.1_len , . - l_.str.1
