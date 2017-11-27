; Executable name       : fanta
; Designed OS           : Linux (32-bit)
; Author                : wetw0rk
; Version               : 1.0
; Created Following     : SLAE
; Description           : A simple program that demonstrates data types.
;			  This program should be ran under (gdb). If you
;			  dont it'll just exit! This may be the only code
;			  that does not include comments for every line
;			  since its pretty self explanitory. :)
;
; Build using these commands:
;	nasm -f elf32 -o fanta.o fanta.asm
;	ld -o fanta fanta.o
;
; How to run and use this program (intention):
;	gdb -q ./fanta
;

SECTION .data

	example1: db 0xFF
	example2: db 0xEE, 0xDD, 0xCC,
	example3: dw 0xBB
	example4: dd 0xDEADBEEF
	example5: dd 0x123456
	example6: times 6 db 0xAA

SECTION .bss

	buff1: resb 100
	buff2: resw 20

SECTION .text

global _start

_start:
	; exit the program since we are just observing assembly's beauty
	mov eax,1				; syscall for exit()
	mov ebx,0				; exit cleanly or 0
	int 80h					; call the kernel
