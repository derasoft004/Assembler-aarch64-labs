.text
.global _main
.align 2
//fmov d0, x0      Перемещаем число в регистр с плавающей точкой
//fcvtzs x1, d0    Преобразуем в целое (x1 будет целой частью)
//mov x1, 0x2d -
// scvtf d0, x0
_main:
    /*
     fmov d0, 0.0
     fmov x0, d0
    */
    adrp x1, hello@PAGE
    add x1, x1, hello@PAGEOFF
    mov x2, hello_len
    bl _print
    
    adrp x1, enter_number1@PAGE
    add x1, x1, enter_number1@PAGEOFF
    mov x2, enter_number1_max_len
    bl _read

    adrp x1, enter_number1@PAGE
    add x1, x1, enter_number1@PAGEOFF
    strb wzr, [x1, x0]  // add 0 to string's end

    add x0, x0, 1

    adrp x2, enter_number1_len@PAGE
    add x2, x2, enter_number1_len@PAGEOFF
    str x0, [x2]

    adrp x1, urnumber@PAGE
    add x1, x1, urnumber@PAGEOFF
    mov x2, urnumber_len
    bl _print

    // преобразование строки в число с _string_to_float

    adrp x0, enter_number1@PAGE
    add x0, x0, enter_number1@PAGEOFF
    
    bl _string_to_float // -> d0 - десятичное число
    fmov d8, d0

    adrp x4, buffer_num1@PAGE
    add x4, x4, buffer_num1@PAGEOFF
    
    adrp x5, enter_number1_len@PAGE
    add x5, x5, enter_number1_len@PAGEOFF
    ldr x5, [x5]
    sub x5, x5, 2

    bl _convert_number_to_string

    adrp x1, buffer_num1@PAGE
    add x1, x1, buffer_num1@PAGEOFF
    mov x2, x7
    bl _print

    adrp x1, end_char@PAGE
    add x1, x1, end_char@PAGEOFF
    mov x2, 1
    bl _print

    adrp x1, task1_string@PAGE
    add x1, x1, task1_string@PAGEOFF
    mov x2, task1_string_len
    bl _print

    adrp x1, task1_rounding_bot_string@PAGE
    add x1, x1, task1_rounding_bot_string@PAGEOFF
    mov x2, task1_rounding_bot_string_len
    bl _print
    

/// === ЗАДАНИЕ 1: ОКРУГЛЕНИЕ ===


    _task1_rounding_bot:
        // вход
        // d1 - десятичное число
        fmov d2, d8 // введенное значнеие
        fcvtzs x1, d2
        scvtf d2, x1
        fmov d5, d2 // d5 - округленное значение (tmp)
        
        bl _get_count_of_symbols_in_number // x0
        mov x5, x0

        adrp x4, buffer_num1_round_bot@PAGE
        add x4, x4, buffer_num1_round_bot@PAGEOFF
        
        
        fmov d0, d5
        
        bl _convert_number_to_string // x7

    adrp x1, buffer_num1_round_bot@PAGE
    add x1, x1, buffer_num1_round_bot@PAGEOFF
    mov x2, x7
    bl _print
    
    adrp x1, end_char@PAGE
    add x1, x1, end_char@PAGEOFF
    mov x2, 1
    bl _print

    adrp x1, task1_rounding_top_string@PAGE
    add x1, x1, task1_rounding_top_string@PAGEOFF
    mov x2, task1_rounding_top_string_len
    bl _print
    
    _task1_rounding_top:
        fmov d2, d8 // введенное значнеие
        fcvtzs x1, d2
        scvtf d2, x1
        fmov d3, 1.0
        fadd d5, d2, d3 // d5 - округленное значение (tmp)

        bl _get_count_of_symbols_in_number // x0
        mov x5, x0

        adrp x4, buffer_num1_round_top@PAGE
        add x4, x4, buffer_num1_round_top@PAGEOFF

        fmov d0, d5

        bl _convert_number_to_string // x7

    adrp x1, buffer_num1_round_top@PAGE
    add x1, x1, buffer_num1_round_top@PAGEOFF
    mov x2, x7
    bl _print

    adrp x1, end_char@PAGE
    add x1, x1, end_char@PAGEOFF
    mov x2, 1
    bl _print


/// === ЗАДАНИЕ 2: УРАВНЕНИЯ ===
    

    adrp x1, task2_string@PAGE
    add x1, x1, task2_string@PAGEOFF
    mov x2, task2_string_len
    bl _print

// a
    adrp x1, parametr_a@PAGE
    add x1, x1, parametr_a@PAGEOFF
    mov x2, parametr_a_len
    bl _print

    adrp x1, enter_patametr_a@PAGE
    add x1, x1, enter_patametr_a@PAGEOFF
    mov x2, enter_patametr_a_max_len
    bl _read

    adrp x1, enter_patametr_a@PAGE
    add x1, x1, enter_patametr_a@PAGEOFF
    strb wzr, [x1, x0]  // add 0 to string's end

    add x0, x0, 1

    adrp x2, enter_patametr_a_len@PAGE
    add x2, x2, enter_patametr_a_len@PAGEOFF
    str x0, [x2]


    adrp x0, enter_patametr_a@PAGE
    add x0, x0, enter_patametr_a@PAGEOFF

    bl _string_to_float // -> d0 - десятичное число
    fmov d11, d0

// b
    adrp x1, parametr_b@PAGE
    add x1, x1, parametr_b@PAGEOFF
    mov x2, parametr_b_len
    bl _print

    adrp x1, enter_patametr_b@PAGE
    add x1, x1, enter_patametr_b@PAGEOFF
    mov x2, enter_patametr_a_max_len
    bl _read

    adrp x1, enter_patametr_b@PAGE
    add x1, x1, enter_patametr_b@PAGEOFF
    strb wzr, [x1, x0]  // add 0 to string's end

    add x0, x0, 1

    adrp x2, enter_patametr_b_len@PAGE
    add x2, x2, enter_patametr_b_len@PAGEOFF
    str x0, [x2]

    adrp x0, enter_patametr_b@PAGE
    add x0, x0, enter_patametr_b@PAGEOFF

    bl _string_to_float // -> d0 - десятичное число
    fmov d12, d0

//c
    adrp x1, parametr_c@PAGE
    add x1, x1, parametr_c@PAGEOFF
    mov x2, parametr_c_len
    bl _print

    adrp x1, enter_patametr_c@PAGE
    add x1, x1, enter_patametr_c@PAGEOFF
    mov x2, enter_patametr_a_max_len
    bl _read

    adrp x1, enter_patametr_c@PAGE
    add x1, x1, enter_patametr_c@PAGEOFF
    strb wzr, [x1, x0]  // add 0 to string's end

    add x0, x0, 1

    adrp x2, enter_patametr_c_len@PAGE
    add x2, x2, enter_patametr_c_len@PAGEOFF
    str x0, [x2]

    adrp x0, enter_patametr_c@PAGE
    add x0, x0, enter_patametr_c@PAGEOFF

    bl _string_to_float // -> d0 - десятичное число
    fmov d13, d0

//x
    adrp x1, parametr_x@PAGE
    add x1, x1, parametr_x@PAGEOFF
    mov x2, parametr_x_len
    bl _print

    adrp x1, enter_patametr_x@PAGE
    add x1, x1, enter_patametr_x@PAGEOFF
    mov x2, enter_patametr_a_max_len
    bl _read

    adrp x1, enter_patametr_x@PAGE
    add x1, x1, enter_patametr_x@PAGEOFF
    strb wzr, [x1, x0]  // add 0 to string's end

    add x0, x0, 1

    adrp x2, enter_patametr_x_len@PAGE
    add x2, x2, enter_patametr_x_len@PAGEOFF
    str x0, [x2]

    adrp x0, enter_patametr_x@PAGE
    add x0, x0, enter_patametr_x@PAGEOFF

    bl _string_to_float // -> d0 - десятичное число
    fmov d14, d0

// уравнения

    _task2_equation1:
        adrp x1, task2_equation1@PAGE
        add x1, x1, task2_equation1@PAGEOFF
        mov x2, task2_equation1_len
        bl _print
        
        fmul d0, d11, d14
        fadd d0, d0, d12
        fdiv d0, d0, d13
        
        adrp x4, buffer_parametr_y1@PAGE
        add x4, x4, buffer_parametr_y1@PAGEOFF
        
        bl _get_count_of_symbols_in_number
        add x5, x0, 8 // возьмем точность 8

        bl _convert_number_to_string // x7, buffer_parametr_y
        
        fcmp d0, 0.0
        bge _is_positive1
        adrp x1, minus_char@PAGE
        add x1, x1, minus_char@PAGEOFF
        mov x2, minus_char_len
        bl _print
 
    _is_positive1:
        adrp x1, buffer_parametr_y1@PAGE
        add x1, x1, buffer_parametr_y1@PAGEOFF
        mov x2, x7
        bl _print

    adrp x1, end_char@PAGE
    add x1, x1, end_char@PAGEOFF
    mov x2, 1
    bl _print

    _task2_equation2:
        adrp x1, task2_equation2@PAGE
        add x1, x1, task2_equation2@PAGEOFF
        mov x2, task2_equation2_len
        bl _print
        
        fmul d0, d12, d14
        fsub d0, d11, d0
        fdiv d0, d0, d13
        
        adrp x4, buffer_parametr_y2@PAGE
        add x4, x4, buffer_parametr_y2@PAGEOFF
        
        bl _get_count_of_symbols_in_number
        add x5, x0, 8 // возьмем точность 8

        bl _convert_number_to_string // x7, buffer_parametr_y
        
        fcmp d0, 0.0
        bge _is_positive2 // не возвращается обратно
        adrp x1, minus_char@PAGE
        add x1, x1, minus_char@PAGEOFF
        mov x2, minus_char_len
        bl _print

    _is_positive2:

        adrp x1, buffer_parametr_y2@PAGE
        add x1, x1, buffer_parametr_y2@PAGEOFF
        mov x2, x7
        bl _print
        
    adrp x1, end_char@PAGE
    add x1, x1, end_char@PAGEOFF
    mov x2, 1
    bl _print

    _task2_equation3:
        adrp x1, task2_equation3@PAGE
        add x1, x1, task2_equation3@PAGEOFF
        mov x2, task2_equation3_len
        bl _print
        
        fdiv d0, d11, d14
        fadd d0, d0, d12
        fmul d0, d0, d13
        
        adrp x4, buffer_parametr_y3@PAGE
        add x4, x4, buffer_parametr_y3@PAGEOFF
        
        bl _get_count_of_symbols_in_number
        add x5, x0, 8 // возьмем точность 8

        bl _convert_number_to_string // x7, buffer_parametr_y
        
        fcmp d0, 0.0
        bge _is_positive3 // не возвращается обратно
        adrp x1, minus_char@PAGE
        add x1, x1, minus_char@PAGEOFF
        mov x2, minus_char_len
        bl _print

    _is_positive3:

        adrp x1, buffer_parametr_y3@PAGE
        add x1, x1, buffer_parametr_y3@PAGEOFF
        mov x2, x7
        bl _print

    adrp x1, end_char@PAGE
    add x1, x1, end_char@PAGEOFF
    mov x2, 1
    bl _print

    _task2_equation4:
        adrp x1, task2_equation4@PAGE
        add x1, x1, task2_equation4@PAGEOFF
        mov x2, task2_equation4_len
        bl _print
        
        fsub d0, d11, d14
        fmul d0, d0, d12
        fdiv d0, d0, d13
        
        adrp x4, buffer_parametr_y4@PAGE
        add x4, x4, buffer_parametr_y4@PAGEOFF
        
        bl _get_count_of_symbols_in_number
        add x5, x0, 8 // возьмем точность 8

        bl _convert_number_to_string // x7, buffer_parametr_y
        
        fcmp d0, 0.0
        bge _is_positive4 // не возвращается обратно
        adrp x1, minus_char@PAGE
        add x1, x1, minus_char@PAGEOFF
        mov x2, minus_char_len
        bl _print

    _is_positive4:

        adrp x1, buffer_parametr_y4@PAGE
        add x1, x1, buffer_parametr_y4@PAGEOFF
        mov x2, x7
        bl _print

    adrp x1, end_char@PAGE
    add x1, x1, end_char@PAGEOFF
    mov x2, 1
    bl _print

    _task2_equation5:
        adrp x1, task2_equation5@PAGE
        add x1, x1, task2_equation5@PAGEOFF
        mov x2, task2_equation5_len
        bl _print
        
        fmul d0, d12, d13
        fadd d1, d11, d14
        fdiv d0, d0, d1
        
        adrp x4, buffer_parametr_y5@PAGE
        add x4, x4, buffer_parametr_y5@PAGEOFF
        
        bl _get_count_of_symbols_in_number
        add x5, x0, 8 // возьмем точность 8

        bl _convert_number_to_string // x7, buffer_parametr_y
        
        fcmp d0, 0.0
        bge _is_positive5
        adrp x1, minus_char@PAGE
        add x1, x1, minus_char@PAGEOFF
        mov x2, minus_char_len
        bl _print

    _is_positive5:

        adrp x1, buffer_parametr_y5@PAGE
        add x1, x1, buffer_parametr_y5@PAGEOFF
        mov x2, x7
        bl _print

    adrp x1, end_char@PAGE
    add x1, x1, end_char@PAGEOFF
    mov x2, 1
    bl _print

    _task2_equation6:
        adrp x1, task2_equation6@PAGE
        add x1, x1, task2_equation6@PAGEOFF
        mov x2, task2_equation6_len
        bl _print
        
        fsub d0, d14, d11
        fmul d0, d0, d13
        fdiv d0, d0, d12
        
        adrp x4, buffer_parametr_y6@PAGE
        add x4, x4, buffer_parametr_y6@PAGEOFF
        
        bl _get_count_of_symbols_in_number
        add x5, x0, 8 // возьмем точность 8

        bl _convert_number_to_string // x7, buffer_parametr_y
        
        fcmp d0, 0.0
        bge _is_positive6
        adrp x1, minus_char@PAGE
        add x1, x1, minus_char@PAGEOFF
        mov x2, minus_char_len
        bl _print

    _is_positive6:

        adrp x1, buffer_parametr_y6@PAGE
        add x1, x1, buffer_parametr_y6@PAGEOFF
        mov x2, x7
        bl _print


    adrp x1, end_char@PAGE
    add x1, x1, end_char@PAGEOFF
    mov x2, 1
    bl _print

    _task2_equation7:
        adrp x1, task2_equation7@PAGE
        add x1, x1, task2_equation7@PAGEOFF
        mov x2, task2_equation7_len
        bl _print
        
        fmul d0, d14, d14
        fdiv d1, d11, d12
        fadd d0, d0, d1
        
        adrp x4, buffer_parametr_y7@PAGE
        add x4, x4, buffer_parametr_y7@PAGEOFF
        
        bl _get_count_of_symbols_in_number
        add x5, x0, 8 // возьмем точность 8

        bl _convert_number_to_string // x7, buffer_parametr_y
        
        fcmp d0, 0.0
        bge _is_positive7
        adrp x1, minus_char@PAGE
        add x1, x1, minus_char@PAGEOFF
        mov x2, minus_char_len
        bl _print

    _is_positive7:

        adrp x1, buffer_parametr_y7@PAGE
        add x1, x1, buffer_parametr_y7@PAGEOFF
        mov x2, x7
        bl _print


    adrp x1, end_char@PAGE
    add x1, x1, end_char@PAGEOFF
    mov x2, 1
    bl _print

    _task2_equation8:
        adrp x1, task2_equation8@PAGE
        add x1, x1, task2_equation8@PAGEOFF
        mov x2, task2_equation8_len
        bl _print
        
        fmul d0, d14, d14
        fadd d0, d0, d11
        fdiv d0, d0, d12
        
        adrp x4, buffer_parametr_y8@PAGE
        add x4, x4, buffer_parametr_y8@PAGEOFF
        
        bl _get_count_of_symbols_in_number
        add x5, x0, 8 // возьмем точность 8

        bl _convert_number_to_string // x7, buffer_parametr_y
        
        fcmp d0, 0.0
        bge _is_positive8
        adrp x1, minus_char@PAGE
        add x1, x1, minus_char@PAGEOFF
        mov x2, minus_char_len
        bl _print

    _is_positive8:

        adrp x1, buffer_parametr_y8@PAGE
        add x1, x1, buffer_parametr_y8@PAGEOFF
        mov x2, x7
        bl _print


    adrp x1, end_char@PAGE
    add x1, x1, end_char@PAGEOFF
    mov x2, 1
    bl _print

    _task2_equation9:
        adrp x1, task2_equation9@PAGE
        add x1, x1, task2_equation9@PAGEOFF
        mov x2, task2_equation9_len
        bl _print
        
        fmul d0, d14, d14
        fdiv d0, d0, d12
        fadd d0, d0, d11

        adrp x4, buffer_parametr_y9@PAGE
        add x4, x4, buffer_parametr_y9@PAGEOFF
        
        bl _get_count_of_symbols_in_number
        add x5, x0, 8 // возьмем точность 8

        bl _convert_number_to_string // x7, buffer_parametr_y
        
        fcmp d0, 0.0
        bge _is_positive9
        adrp x1, minus_char@PAGE
        add x1, x1, minus_char@PAGEOFF
        mov x2, minus_char_len
        bl _print

    _is_positive9:

        adrp x1, buffer_parametr_y9@PAGE
        add x1, x1, buffer_parametr_y9@PAGEOFF
        mov x2, x7
        bl _print

    adrp x1, end_char@PAGE
    add x1, x1, end_char@PAGEOFF
    mov x2, 1
    bl _print

 
/// === ЗАДАНИЕ 3: НАХОЖДЕНИЕ КОРНЕЙ  ===
    
    
    adrp x1, task3_string@PAGE
    add x1, x1, task3_string@PAGEOFF
    mov x2, task3_string_len
    bl _print

    _task3_equation1:
        adrp x1, task3_equation1@PAGE
        add x1, x1, task3_equation1@PAGEOFF
        mov x2, task3_equation1_len
        bl _print

        adrp x1, end_char@PAGE
        add x1, x1, end_char@PAGEOFF
        mov x2, 1
        bl _print

// дискриминант d4
        fmul d1, d12, d12
        fmov d2, 4
        fmul d3, d11, d13
        fmul d2, d2, d3
        fsub d4, d1, d2

        // корень дискриминанта
        fcmp d4, 0.0
        beq _diskriminant_is_zero
        bge _diskriminant_is_not_negative
        adrp x1, task3_there_are_not_roots@PAGE
        add x1, x1, task3_there_are_not_roots@PAGEOFF
        mov x2, task3_there_are_not_roots_len
        bl _print
        b _task4_start
        

    _diskriminant_is_zero:
        // считаем одиночный корень
        

    _diskriminant_is_not_negative:
        bl _diskriminant_root // d10 - корень

// корни d15, d16
        fmov d1, -1.0

        fmul d2, d12, d1

        fsub d2, d2, d10
        fmov d3, 2.0
        fmul d4, d11, d3
        fdiv d15, d2, d4 // (-b-|D)/2a


        fmul d2, d12, d1
        
        fadd d2, d2, d10
        fmov d3, 2.0
        fmul d4, d11, d3
        fdiv d16, d2, d4 // (-b+|D)/2a
        
        fmov d0, d16
        adrp x4, buffer_task31_parametr_x1@PAGE
        add x4, x4, buffer_task31_parametr_x1@PAGEOFF

        bl _get_count_of_symbols_in_number
        add x5, x0, 8
        bl _convert_number_to_string // x7

        adrp x1, task3_root1@PAGE
        add x1, x1, task3_root1@PAGEOFF
        mov x2, task3_root1_len
        bl _print

        fcmp d0, 0.0
        bge _is_positive311
        adrp x1, minus_char@PAGE
        add x1, x1, minus_char@PAGEOFF
        mov x2, minus_char_len
        bl _print

    _is_positive311:

        adrp x1, buffer_task31_parametr_x1@PAGE
        add x1, x1, buffer_task31_parametr_x1@PAGEOFF
        mov x2, x7
        bl _print

        adrp x1, end_char@PAGE
        add x1, x1, end_char@PAGEOFF
        mov x2, 1
        bl _print

        fmov d0, d15
        adrp x4, buffer_task31_parametr_x2@PAGE
        add x4, x4, buffer_task31_parametr_x2@PAGEOFF

        bl _get_count_of_symbols_in_number
        add x5, x0, 8
        bl _convert_number_to_string // x7

        adrp x1, task3_root2@PAGE
        add x1, x1, task3_root2@PAGEOFF
        mov x2, task3_root2_len
        bl _print
    
        fcmp d0, 0.0
        bge _is_positive312
        adrp x1, minus_char@PAGE
        add x1, x1, minus_char@PAGEOFF
        mov x2, minus_char_len
        bl _print

    _is_positive312:
        adrp x1, buffer_task31_parametr_x2@PAGE
        add x1, x1, buffer_task31_parametr_x2@PAGEOFF
        mov x2, x7
        bl _print

    adrp x1, end_char@PAGE
    add x1, x1, end_char@PAGEOFF
    mov x2, 1
    bl _print

// === ЗАДАНИЕ 4: ПРОВЕРКА ТОЧКИ  ===

_task4_start:
    adrp x1, task4_string@PAGE
    add x1, x1, task4_string@PAGEOFF
    mov x2, task4_string_len
    bl _print

// x
    adrp x1, enter_patametr_x4_string@PAGE
    add x1, x1, enter_patametr_x4_string@PAGEOFF
    mov x2, enter_patametr_x4_string_len
    bl _print

    adrp x1, enter_patametr_x4@PAGE
    add x1, x1, enter_patametr_x4@PAGEOFF
    mov x2, enter_patametr_x4_max_len
    bl _read

    adrp x1, enter_patametr_x4@PAGE
    add x1, x1, enter_patametr_x4@PAGEOFF
    strb wzr, [x1, x0]  // add 0 to string's end

    add x0, x0, 1

    adrp x2, enter_patametr_x4_len@PAGE
    add x2, x2, enter_patametr_x4_len@PAGEOFF
    str x0, [x2]


    adrp x0, enter_patametr_x4@PAGE
    add x0, x0, enter_patametr_x4@PAGEOFF

    bl _string_to_float // -> d0 - десятичное число
    fmov d11, d0

// y
    adrp x1, enter_patametr_y4_string@PAGE
    add x1, x1, enter_patametr_y4_string@PAGEOFF
    mov x2, enter_patametr_y4_string_len
    bl _print

    adrp x1, enter_patametr_y4@PAGE
    add x1, x1, enter_patametr_y4@PAGEOFF
    mov x2, enter_patametr_y4_max_len
    bl _read

    adrp x1, enter_patametr_y4@PAGE
    add x1, x1, enter_patametr_y4@PAGEOFF
    strb wzr, [x1, x0]  // add 0 to string's end

    add x0, x0, 1

    adrp x2, enter_patametr_y4_len@PAGE
    add x2, x2, enter_patametr_y4_len@PAGEOFF
    str x0, [x2]

    adrp x0, enter_patametr_y4@PAGE
    add x0, x0, enter_patametr_y4@PAGEOFF

    bl _string_to_float // -> d0 - десятичное число
    fmov d12, d0

_task4_equation: // d11 - x, d12 - y
    adrp x1, task4_equation1@PAGE
    add x1, x1, task4_equation1@PAGEOFF
    mov x2, task4_equation1_len
    bl _print


_looooker:
    fmov d0, d11
    bl _get_log_degree // d10 - значение логарифма (степень)

    fcmp d10, d12
    beq _print_true
    
    adrp x1, false_string@PAGE
    add x1, x1, false_string@PAGEOFF
    mov x2, false_string_len
    bl _print
    bl _exit
    

_print_true:
    adrp x1, true_string@PAGE
    add x1, x1, true_string@PAGEOFF
    mov x2, true_string_len
    bl _print


    bl _exit






_get_log_degree: // десятичный логарифм
// вход
// d0 - число в аргументе
// выход
// d10 - степень

fmov d1, d0 // число

fmov d2, 1.0  // current degree
fmov d4, 2.0  // current degree

fmov d6, 10.0 // d7 - основание
fmov d7, 1.0 // d6 - текущее 1 значение
fmov d8, 10.0 // d6 - текущее 2 значение

fcmp d1, 0.0
fmov d10, -1.0 // error
beq _get_log_degree_ret


fmov d10, 1.0
fcmp d1, d10
fmov d10, 0
beq _get_log_degree_ret

fmov d10, 10.0
fcmp d1, d10
fmov d10, 0.5
blt _get_log_degree_ret


_selection_loop_log_degree:
    fmul d7, d7, d6 // 10^d2
    fcmp d1, d7
    beq _is_log_degree_exactly2
    bge _check_right_log_degree
    b _next_log_degree_step

_check_right_log_degree:
    fmul d8, d8, d6 // 10^d4
    fcmp d1, d8
    beq _is_log_degree_exactly4
    blt _here_log_degree

_next_log_degree_step:
    fmov d9, 1.0
    fadd d2, d2, d9
    fadd d4, d4, d9
    b _selection_loop_log_degree

_is_log_degree_exactly2:
    fmov d10, d2
    b _get_log_degree_ret

_is_log_degree_exactly4:
    fmov d10, d4
    b _get_log_degree_ret
    
_here_log_degree:
    fadd d2, d2, d4
    fmov d8, 2.0
    fdiv d6, d2, d8
    fmov d10, d6


_get_log_degree_ret:
ret







_diskriminant_root:
/*
 вход
 d4 - дискриминант
 выход
 d10 - корень
 */ // 12
    fmov d5, 0.0 // 3  9
    fmov d7, 1.0 // 4  16

_selection_loop:
    fmul d6, d5, d5
    fcmp d4, d6
    beq _is_root_exactly5
    bge _check_right
    b _next_root_step

_check_right:
    fmul d8, d7, d7
    fcmp d4, d8
    beq _is_root_exactly7
    blt _here_root

_next_root_step:
    fmov d9, 1.0
    fadd d5, d5, d9
    fadd d7, d7, d9
    b _selection_loop

_is_root_exactly5:
    fmov d10, d5

_is_root_exactly7:
    fmov d10, d7
    
_here_root:
    fadd d6, d5, d7
    fmov d8, 2.0
    fdiv d6, d6, d8
    fmov d10, d6
    ret
    
    






_get_count_of_symbols_in_number: // только для 1 задания (потому что про числа > 0)
    /*
     вход
     d0 - number
     выход
     x0 - количество символов
     */
    fmov d1, d0
    mov x0, 0 // count

_fdiv_loop:
    fmov d2, 10
    fdiv d1, d1, d2
    
    add x0, x0, 1

    fcvtzs x1, d1
    cbnz x1, _fdiv_loop

    //add x0, x0, 2 // 2 для .0 (десятичное число)
    ret



_string_to_float:
    /*
     вход
     x0 - указатель на строку
     выход
     d0 - число с плавающей точкой, полученное из строки
     */
    mov x10, lr

    fmov d0, 0.0
    mov x1, 0             // индекс
    mov x2, 1             //  (1 - целая, 0 - дробная)
    fmov d1, 1.0
    adrp x5, num01@PAGE // 0.1
    add x5, x5, num01@PAGEOFF
    ldr d5, [x5]
    ldr d7, [x5]

_loop:
    ldrb w3, [x0, x1]
    cmp w3, 0x0000000a  // проверяем достигли ли конца строки (нулевой символ(тут как то странно но вот так))
    beq _done
    
    subs w4, w3, '0'
    cmp w4, 10
    blt _check_decimal

    cmp w3, '.'
    beq _decimal_found      // если точка переходим к дробной части

    // если символ не является цифрой или точкой возвращаем 0
    fmov d0, 0.0
    ret

_check_decimal:
    cmp w3, '.'            // проверяем, не является ли символ точкой (0x000000000000002e)
    beq _decimal_found
    b _valid_digit

_valid_digit:
    cmp x2, 1              // проверяем в какой части числа находимся
    beq _integer_part
    scvtf d6, x4
    fmul d6, d6, d7      // умножаем на 0.1 для дробной части
    fadd d0, d0, d6
    fmul d7, d7, d5
    b _next

_integer_part:
    // Умножаем текущее значение на 10
    fmov d3, 10.0
    fmul d0, d0, d3
    scvtf d6, x4
    fadd d0, d0, d6
    b _next

_decimal_found:
    mov x2, 0              // устанавливаем флаг для дробной части

_next:
    add x1, x1, 1
    b _loop

_done:
    br x10






_convert_number_to_string: // (d0, x4, x5) -> x7 и число в буфере
    /* вход
     d0 - десятичное число для преобразования в строку
     x4 - буфер
     x5 - длина самого числа буфера
     выход
     x7 - количество знаков в числе (передается 0)
     */
    mov x10, lr
    mov x7, 0 // количество знаков в числе (x7)
        
    fmov d6, d0
    fcmp d6, 0.0
    bge _is_positive_number
    fmov d5, -1.0
    fmul d6, d6, d5
_is_positive_number:

    fcvtzs x0, d6

    mov x6, x4

_convert_integer_loop:
    mov x1, x0
    mov x9, 10
    udiv x2, x1, x9 // 98
    mul x3, x2, x9
    sub x1, x0, x3  // 987 - 980
    add x1, x1, 0x30

    // save numbers to buffer
    strb w1, [x6]
    add x6, x6, 1
    mov x0, x2  // update x0 for next iteration 98

    add x7, x7, 1
    sub x5, x5, 1
    //cbnz x0, _convert_integer_loop  //  x0 != 0  -> _convert_loop
    adrp x11, const_value@PAGE
    add x11, x11, const_value@PAGEOFF
    ldr x11, [x11]
    cmp x0, x11 // добавить обработку на минусяру ------
    beq _go_next_it_s_minus
    cbnz x0, _convert_integer_loop
    
_go_next_it_s_minus:

    strb wzr, [x6]

    sub x6, x6, 1
    mov x8, x6
    mov x9, x4

_reverse_loop:
    cmp x9, x8
    bge _add_point

    // swap
    ldrb w1, [x9]
    ldrb w2, [x8]
    strb w1, [x8]
    strb w2, [x9]

    add x9, x9, 1
    sub x8, x8, 1
    b _reverse_loop


_add_point:
    // получим буфер и переместимся в его конец чтоб поставить точку
    mov x1, x4
    add x1, x1, x7
    mov w2, '.'
    add x7, x7, 1
    sub x5, x5, 1
    strb w2, [x1]

_convert_decimal_part:
    fcvtzs x0, d6
    scvtf d1, x0
    fsub d2, d6, d1 // d2 - десятичная часть числа = 0.123
    fmov d3, 10.0

_convert_decimal_loop:
    mov x2, x4
    cmp x5, 0xffffffffffffffff
    beq _add_zero
    fmul d4, d2, d3 // 1.23

    fcvtzs x1, d4 // у последнего числа происходит -0.000000000001 (4=3,999999999) (?)
    add x1, x1, 0x30

    sub x5, x5, 1
    add x7, x7, 1

    add x2, x2, x7 // к буферу добавим счетчик и туда запишем
    strb w1, [x2]
    
    fcvtzs x0, d4
    scvtf d1, x0
    fsub d2, d4, d1 // обновим d0
    
    cbnz x5, _convert_decimal_loop
    
_add_zero:
    mov x1, 0x30
    add x2, x2, x7
    strb w1, [x2]

_return_to_code:
    add x7, x7, 1
    add x2, x2, x7
    strb wzr, [x2]
    add x7, x7, 1
    br x10



_read:
    mov x0, 0
    mov x16, 3
    svc 0
    ret

_print:
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
.align 3
    task1_string: .asciz "Task 1. Rounding number\n" // =======================================
    .equ task1_string_len, . - task1_string

    hello: .asciz "Hello! Enter the float-point number for Task 1: "
    .equ hello_len, . - hello
    urnumber: .asciz "Your number: "
    .equ urnumber_len, . - urnumber

// для задания 1: x
    enter_number1: .fill 255, 1, 0
    .equ enter_number1_max_len, . - enter_number1
    enter_number1_len: .quad 0

    buffer_num1: .space 255
    buffer_num1_round_bot: .space 255
    buffer_num1_round_top: .space 255

    task1_rounding_top_string: .asciz " Rounding top: "
    .equ task1_rounding_top_string_len, . - task1_rounding_top_string

    task1_rounding_bot_string: .asciz " Rounding bottom: "
    .equ task1_rounding_bot_string_len, . - task1_rounding_bot_string
.align 3
    task2_string: .asciz "Task 2. Equations.\n" // ============================================
    .equ task2_string_len, . - task2_string

    parametr_a: .asciz "Enter float-point patametr a: "
    .equ parametr_a_len, . - parametr_a
    parametr_b: .asciz "Enter float-point patametr b: "
    .equ parametr_b_len, . - parametr_b
    parametr_c: .asciz "Enter float-point patametr c: "
    .equ parametr_c_len, . - parametr_c
    parametr_x: .asciz "Enter float-point patametr x: "
    .equ parametr_x_len, . - parametr_x
    

// для задания 2: a, b, c, x
    enter_patametr_a: .fill 255, 1, 0
    .equ enter_patametr_a_max_len, . - enter_patametr_a
    enter_patametr_a_len: .quad 0

    enter_patametr_b: .fill 255, 1, 0
    .equ enter_patametr_b_max_len, . - enter_patametr_b
    enter_patametr_b_len: .quad 0

    enter_patametr_c: .fill 255, 1, 0
    .equ enter_patametr_c_max_len, . - enter_patametr_c
    enter_patametr_c_len: .quad 0

    enter_patametr_x: .fill 255, 1, 0
    .equ enter_patametr_x_max_len, . - enter_patametr_x
    enter_patametr_x_len: .quad 0

    buffer_parametr_a: .space 255
    buffer_parametr_b: .space 255
    buffer_parametr_c: .space 255
    buffer_parametr_x: .space 255
    buffer_parametr_y1: .space 255
    buffer_parametr_y2: .space 255
    buffer_parametr_y3: .space 255
    buffer_parametr_y4: .space 255
    buffer_parametr_y5: .space 255
    buffer_parametr_y6: .space 255
    buffer_parametr_y7: .space 255
    buffer_parametr_y8: .space 255
    buffer_parametr_y9: .space 255

    task2_equation1: .asciz " Equation 1: y=(ax+b)/c   : "
    .equ task2_equation1_len, . - task2_equation1

    task2_equation2: .asciz " Equation 2: y=(a-bx)/c   : "
    .equ task2_equation2_len, . - task2_equation2

    task2_equation3: .asciz " Equation 3: y=(a/x+b)c   : "
    .equ task2_equation3_len, . - task2_equation3

    task2_equation4: .asciz " Equation 4: y=((a-x)b)/c : "
    .equ task2_equation4_len, . - task2_equation4

    task2_equation5: .asciz " Equation 5: y=(bc)/(a+x) : "
    .equ task2_equation5_len, . - task2_equation5

    task2_equation6: .asciz " Equation 6: y=(x-a)c/b   : "
    .equ task2_equation6_len, . - task2_equation6

    task2_equation7: .asciz " Equation 7: y=x^2+(a/b)  : "
    .equ task2_equation7_len, . - task2_equation7

    task2_equation8: .asciz " Equation 8: y=(x^2+a)/b  : "
    .equ task2_equation8_len, . - task2_equation8

    task2_equation9: .asciz " Equation 9: y=x^2/b+a    : "
    .equ task2_equation9_len, . - task2_equation9

.align 3
    task3_string: .asciz "Task 3. Solve Equation. (will use the same parametrs a, b, c)\n" // =
    .equ task3_string_len, . - task3_string

    task3_equation1: .asciz " Equation 1: ax^2+bx+c=0 "
    .equ task3_equation1_len, . - task3_equation1


    buffer_task31_parametr_x1: .space 255
    buffer_task31_parametr_x2: .space 255
    buffer_task31_parametr_dick: .space 255


    task3_root1: .asciz " Root 1 : "
    .equ task3_root1_len, . - task3_root1

    task3_root2: .asciz " Root 2 : "
    .equ task3_root2_len, . - task3_root2


    task3_there_are_not_roots: .asciz "There are not roots. \n" // =
    .equ task3_there_are_not_roots_len, . - task3_there_are_not_roots

.align 3
    task4_string: .asciz "Task 4. Check point.\n" // =
    .equ task4_string_len, . - task4_string

    task4_equation1: .asciz " Equation: y=log10(x) "
    .equ task4_equation1_len, . - task4_equation1

    enter_patametr_x4_string: .asciz " Enter x : "
    .equ enter_patametr_x4_string_len, . - enter_patametr_x4_string

    enter_patametr_y4_string: .asciz " Enter y : "
    .equ enter_patametr_y4_string_len, . - enter_patametr_y4_string


    enter_patametr_x4: .fill 255, 1, 0
    .equ enter_patametr_x4_max_len, . - enter_patametr_x4
    enter_patametr_x4_len: .quad 0

    enter_patametr_y4: .fill 255, 1, 0
    .equ enter_patametr_y4_max_len, . - enter_patametr_y4
    enter_patametr_y4_len: .quad 0



.align 3
    end_char: .asciz "\n"
    num01: .double 0.1
.align 3
    const_value: .quad 0x1999999999999999
    minus_char: .asciz "-"
    .equ minus_char_len , . - minus_char

    false_string: .asciz " FALSE \n"
    .equ false_string_len, . - false_string

    true_string: .asciz " TRUE \n"
    .equ true_string_len, . - true_string



