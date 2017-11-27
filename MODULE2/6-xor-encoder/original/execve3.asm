; Executable name       : execve3
; Designed OS           : Linux (32-bit)
; Author		: wetw0rk
; Version               : 1.0
; Created Following     : SLAE
; Description           : An example of execve usage in shellcode via the stack
;			  I got it down to 19 bytes :D!
;
; Build using these commands:
;       nasm -f elf32 -o execve3.o execve3.asm
;       ld -o execve3 execve3.o
;       objdump -D execve3 -M intel
;

SECTION .text

global _start

_start:

	xor eax,eax			; zero out the register
	push eax			; PUSH EAX onto the stack NULLS

	push 0x68732f2f			; simply /bin//sh but
	push 0x6e69622f			; backwards.

	mov al,11                       ; make the execve() syscall

	mov ebx,esp			; MOV the address stored in ESP
					; which points to top of the stack,
					; which points to [<example>][NULLS]

	int 80h				; call the kernel

