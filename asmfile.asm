section .data
    divisor dq 255.0 ; Divisor as a floating-point constant (double-precision)

section .text
bits 64
default rel
global imgCvtGrayIntToDouble

imgCvtGrayIntToDouble:
    ; Arguments: 
    ; rcx = rows
    ; rdx = cols
    ; r8 = input array pointer (unsigned char*)
    ; r9 = output array pointer (double*)

    ; Calculate total number of elements: rcx = rows * cols
    mov rax, rcx
    mul rdx
    mov rcx, rax        ; rcx now contains total number of pixels

    ; rsi = input array pointer, rdi = output array pointer
    mov rsi, r8
    mov rdi, r9

L1:
    ; Load current element from the input array into AL
    movzx rax, byte [rsi] ; Zero-extend the byte to 64-bit register rax

    ; Convert the integer to double (floating-point)
    cvtsi2sd xmm0, rax    ; Convert rax (integer) to double in xmm0

    ; Divide xmm0 by divisor (255.0)
    movsd xmm1, qword [rel divisor] ; Load divisor into xmm1
    divsd xmm0, xmm1                ; xmm0 = xmm0 / xmm1

    ; Store the result in the output array
    movsd qword [rdi], xmm0

    ; Increment input and output pointers
    inc rsi                ; Move to the next input element (byte)
    add rdi, 8             ; Move to the next output element (double)

    ; Decrement the counter and loop
    dec rcx
    jnz L1

    ret
