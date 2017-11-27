; Executable name       : exit2
; Designed OS           : Linux (32-bit)
; Author		: wetw0rk
; Version               : 1.0
; Created Following     : SLAE
; Description           : An example of exit shellcode, without NULL bytes
;
; Build using these commands:
;       nasm -f elf32 -o exit2.o exit2.asm
;       ld -o exit2 exit2.o
;	objdump -d exit2 -M intel
;

SECTION .text

global _start

_start:
	xor eax,eax	; zero out register
	mov al,1	; make the exit() syscall
	xor ebx,ebx	; zero out register
	mov bl,1	; exit
	int 80h		; call the kernel
