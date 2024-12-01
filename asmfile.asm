section .data
	divisor db 255

section .bss
	result resq 1000

section .text
bits 64
default rel
global imgCvtGrayIntToDouble
imgCvtGrayIntToDouble:
    ; Arguments: 
    ; rcx = rows
    ; rdx = height
	; r8 = arr point
	; r9 = result
	
    ; Load the array pointer (arr) into rsi
    mov rax, rcx	; Move the value of rcx (rows) into rax
    mul rdx 
    mov rcx, rdx	; size of the array (passed as second argument)
	
	lea rdi, [r9] ; result buffer
	lea rsi, [r8] 
    ; Loop to process the array
L1:
	; Load the current element of the array into al
    mov al, [rsi]        ; AL = *rsi (current element in the array)

	xor ah, ah
	mov dl, [divisor]
	div dl
	
	cvtsi2sd xmm0, rax 
	movsd [rdi], xmm0
	
    ; Move to the next element in the array
    inc rsi                ; Move pointer to the next array element
	add rsi, 8
    ; Decrement the size counter (rcx)
    dec rcx                ; Decrement rcx (loop counter)
    jnz L1        ; Jump to start of loop if rcx != 0

    xor rax, rax
    ret

