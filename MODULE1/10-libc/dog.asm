; Executable name       : dog
; Designed OS           : Linux (32-bit)
; Author                : wetw0rk
; Version               : 1.0
; Created Following     : SLAE
; Description           : A simple program that shows how to call libc functions
;
; Build using these commands:
;       nasm -f elf32 -o dog.o dog.asm
;       gcc -o dog dog.o
;

extern printf, exit		; these come from libc

SECTION .data

	dogs: db "Bark Bark",10
	dlen: EQU $-dogs

SECTION .text

global main

main:
	push dogs		; PUSH dogs string onto the stack
	call printf		; call printf
	add esp,4		; adjust the stack

	mov eax,0		; clean exit
	call exit		; exit the program
