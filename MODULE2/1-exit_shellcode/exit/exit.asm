; Executable name       : exit
; Designed OS           : Linux (32-bit)
; Author		: wetw0rk
; Version               : 1.0
; Created Following     : SLAE
; Description           : An example of exit shellcode
;
; Build using these commands:
;       nasm -f elf32 -o exit.o exit.asm
;       ld -o exit exit.o
;	objdump -d exit -M intel
;

SECTION .text

global _start

_start:
	mov eax,1	; make the exit() syscall
	mov ebx,0	; exit cleanly or 0
	int 80h		; call the kernel
