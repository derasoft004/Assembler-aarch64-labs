.text
.global _main
.align 2

_main:
    adrp x1, hello_prompt@PAGE
    add x1, x1, hello_prompt@PAGEOFF
    mov x2, hello_prompt_len
    bl _print

    adrp x1, name@PAGE
    add x1, x1, name@PAGEOFF
    mov x2, max_name_len
    bl _read

    mov x0, x0

    adrp x1, name@PAGE
    add x1, x1, name@PAGEOFF
    strb wzr, [x1, x0]  // add 0 to string's end

    add x0, x0, 1

    adrp x2, name_len@PAGE
    add x2, x2, name_len@PAGEOFF
    str x0, [x2]

    adrp x7, name@PAGE
    add x7, x7, name@PAGEOFF

    mov x4, 0   // index
    mov x5, 0   // count
    bl _while_start

_return_to_code:

    mov x5, x0
    

    adrp x1, output_msg@PAGE
    add x1, x1, output_msg@PAGEOFF
    mov x2, output_msg_len
    bl _print

    adrp x4, buffer@PAGE
    add x4, x4, buffer@PAGEOFF

    mov x0, x5  // 999

    mov x6, x4
    mov x7, 0   // count for number len

_convert_loop:
    mov x1, x0
    mov x9, 10
    udiv x2, x1, x9
    mul x3, x2, x9
    sub x1, x0, x3  // 990 - 999
    add x1, x1, 0x30

    // save numbers to buffer
    strb w1, [x6]
    add x6, x6, 1   // end of buffer
    mov x0, x2  // update x0 for next iteration

    add x7, x7, 1
    cbnz x0, _convert_loop  //  x0 != 0  -> _convert_loop

    strb wzr, [x6]

    sub x6, x6, 1
    mov x8, x6
    mov x9, x4

_reverse_loop:
    cmp x9, x8
    bge _end_convert_loop

    // swap
    ldrb w1, [x9]
    ldrb w2, [x8]
    strb w1, [x8]
    strb w2, [x9]

    add x9, x9, 1
    sub x8, x8, 1
    b _reverse_loop

_end_convert_loop:
    

    adrp x4, buffer@PAGE
    add x4, x4, buffer@PAGEOFF
    
    mov x1, x4
    mov x2, x7
    bl _print
    
    adrp x1, end_char@PAGE
    add x1, x1, end_char@PAGEOFF
    mov x2, 1
    bl _print
    
    bl _exit


_print:
    mov x0, 1
    mov x16, 4
    svc 0
    ret

_read:
    mov x0, 0
    mov x16, 3
    svc 0
    ret
    

_while_start:
    ldrb w8, [x7, x4]
    cmp w8, wzr
    beq _while_end
    
    cmp w8, 'E'
    beq _found
    cmp w8, 'e'
    beq _found
    cmp w8, 'Z'
    b.eq _found
    cmp w8, 'z'
    beq _found

_increment:
    add x4, x4, 1
    bl _while_start

_found:
    add x5, x5, 1
    bl _increment

_while_end:
    mov x0, x5
    bl _return_to_code
    ret

_exit:
    mov x0, 0
    mov x16, 1
    svc 0
    ret


.data
hello_prompt: .asciz "Input the string which program will look for words containing symbols: 'Z' or 'E' in: "
.equ hello_prompt_len, . - hello_prompt
name_len: .quad 0
name: .fill 256, 1, 0
.equ max_name_len, . - name
output_msg: .asciz "count of your name's and surname's first letters: "
.equ output_msg_len, . - output_msg
end_char: .asciz "\n"
buffer: .space 12
