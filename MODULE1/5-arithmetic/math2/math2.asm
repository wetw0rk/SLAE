; Executable name       : math2
; Designed OS           : Linux (32-bit)
; Author                : wetw0rk
; Version               : 1.0
; Created Following     : SLAE
; Description           : A simple program that shows how arithmetic
;                         in assembly works. Particularly division
;			  and multiplication
;
; Build using these commands:
;       nasm -f elf32 -o math2.o math2.asm
;       ld -o math2 math2.o
;
; How to run and use this program (intention):
;       gdb -q ./math2
;

SECTION .data

	; dont ask why I called variables buff
	buff1: db 0x05
	buff2: dw 0x1122
	buff3: dd 0x11111111

SECTION .text

global _start

_start:
	; Example of unsigned r/m8 multiplication
	mov al,0x10			; MOV 0x10 into AL
	mov bl,0x2			; MOV 0x2 into BL
	mul bl				; MUL-tiply BL by AL the answer/sum should be
					; stored in AX

	mov al,0xff			; MOV 0xff into AL
	mul bl				; MUL-tiply BL by AL(0xff). the CF and OF flag should be set.
					; The answer/sum should be stored in AX

	; Example of unsigned r/m16 multiplication
	xor eax,eax			; zero out the 32bit register for next example
	xor ebx,ebx			; zero out the 32bit register for next example

	mov ax,0x1111			; MOV 0x1111 into AX
	mov bx,0x0003			; MOV 0x0003 into BX
	mul bx				; MUL-tiply BX by AX. The answer/sum should be in AX.

	mov ax,0x1337			; MOV 0x1337 into AX
	mov bx,0x1337			; MOV 0x1337 into BX
	mul bx				; MUL-tiply AX by BX. The CF and OF flag should me set.
					; since this is hex and 1337h*1337h = 17135D1 the answer/sum
					; will be stored in the following way. EDX = 171, EAX = 35d1
					; nice eh?

	; Example of unsigned r/m32 multiplication
	mov eax,0x11111111		; MOV 0x11111111 into EAX
	mov ebx,0x22222222		; MOV 0x22222222 into EBX
	mul ebx				; MUL-tiply EAX by EBX. The answer should ne stored in
					; EAX and EDX. Remember hex! EAX should = eca8642 and
					; EDX = 2468acf. Making the answer = 2468acf10eca8642
					; noice :)

	mov eax,0x22222222		; MOV 0x22222222 into EAX
	mov ebx,0x00000005		; MOV 0x55555555 into EBX
	mul ebx				; MUL-tiply EAX by EBX. The answer should be in EAX
					; which should be 0xaaaaaaaa

	; Example of multiplication using memory locations
	mul byte [buff1]		; MUL-tiply ^ (0xaaaaaaaa)*(0x05) which CF and OF will be set
					; since = 355555552
	mul word [buff2]		; MUL-tiply ^ (0xaaaa0352)*(0x1122) which will active CF and
					; OF, since = b6bf4cce2e4
	mul dword [buff3]		; Pretty much the same as above. Step through to see where
					; the sum is stored although you can guess/know at this point

	; Example of division using r/m16
	mov dx,0x0			; zero out 16bits
	mov ax,0x7788			; MOV 0x7788 into AX
	mov cx,0x2			; MOV 0x2 into CX
	div cx				; DIV-ide AX by CX, meaning AX should contain 0x3bc4

	mov ax,0x8877 + 0x1		; MOV 0x8877 + 0x1 (0x8878) into AX
	mov cx,0x2			; MOV 0x2 into CX
	div cx				; DIV-ide AX by CX which sum will be stored in AX
					; answer will be 0x443c

	; exit the program cleanly (mr clean-clean) as always
	mov eax,1			; exit() syscall
	mov ebx,0			; 0 for clean exit
	int 80h				; call the kernel
