; Executable name	: panda
; Designed OS		: Linux (32-bit)
; Author		: wetw0rk
; Version		: 1.0
; Created Following	: SLAE
; Description		: A simple program that prints a string
;			  onto the screen.
;
; Build using these commands:
;	nasm -f elf32 -o panda.o panda.asm
;	ld -o panda panda.o
;	objdump -d panda -M intel

SECTION .text

global _start

_start:

	jmp short call_shellcode

shellcode:

	xor eax,eax			; zero out (remove nulls)
	mov al,4			; syscall for write()
	xor ebx,ebx			; zero out
	mov bl,1			; fd == 1 or STDOUT
	pop ecx				; our string to be printed
	xor edx,edx			; zero out
	mov dl,47			; the length of our string
	int 80h				; call the kernel
	xor eax,eax			; zero out
	mov al,1			; syscall for exit()
	xor ebx,ebx			; zero out (0 == clean)
	int 80h				; call the kernel

call_shellcode:

	call shellcode
	desiigner: db "Black X6, Phantom, White X6 looks like a Panda",10
