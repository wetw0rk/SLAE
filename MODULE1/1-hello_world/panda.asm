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
;

SECTION .data

	desiigner: db "Black X6, Phantom, White X6 looks like a Panda",10
	quote_len: equ $-desiigner

SECTION .bss

SECTION .text

global _start

_start:
	mov eax,4			; syscall for write()
	mov ebx,1			; fd == 1 or STDOUT
	mov ecx,desiigner		; our string to be printed
	mov edx,quote_len		; the length of our string
	int 80h				; call the kernel

	mov eax,1			; syscall for exit()
	mov ebx,0			; exit cleanly or 0
	int 80h				; call the kernel

