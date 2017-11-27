; Executable name       : weasel
; Designed OS           : Linux (32-bit)
; Author                : wetw0rk
; Version               : 1.0
; Created Following     : SLAE
; Description           : A simple program that shows how the stack
;			  functions. This program is meant to be ran
;			  under the GNU debugger.
;
; Build using these commands:
;	nasm -f elf32 -o weasel.o weasel.asm
;	ld -o weasel weasel.o
;
; How to run and use this program (intention):
;	gdb -q ./weasel
;

SECTION .data

	PopGoes: db 0xAA, 0xBB, 0xCC, 0xDD, 0xEE, 0xFF, 0x10, 0x11

SECTION .text

global _start

_start:
	mov eax,0xdeadbeef		; MOV 0xdeadbeef into EAX

	; Here is were the weasel begins to pop
	push ax				; PUSH AX (2 bytes) onto the stack (0xefbe)
	pop bx				; POP BX (2 bytes) from the stack onto BX (0xbeef)

	push eax			; PUSH EAX (4 bytes) onto the stack (0xefbeadde)
	pop ecx				; POP ECX (4 bytes) from stack onto ECX (0xdeadbeef)

	; Example of memory push and pop
	push word [PopGoes]		; PUSH 2 bytes (0xAA, 0xBB) onto the stack from [PopGoes]
	pop ecx				; POP 4 bytes from the stack onto ECX

	push dword [PopGoes]		; PUSH 4 bytes from [PopGoes] (0xAA,0xBB,0xCC,0xDD) onto stack
	pop edx				; POP 4 bytes from the stack onto EDX

	; Example of popad and pushad
	pushad				; PUSH all GP registers onto the stack

	xor eax,eax			; this is the same as MOV EAX,0
	xor ebx,ebx			; ^
	xor ecx,ecx			; | zero-ing out
	xor edx,edx			; |

	popad				; POP saved values from the stack back to GP registers
					; The following registers should contain: EAX = 0xdeadbeef,
					; EBX = 0xbeef, ECX = 0x1bbaa, EDX = 0xddccbbaa. This is
					; awesome :)

	; This should be second nature by now
	mov eax,1			; syscall for exit()
	mov ebx,0			; exit cleanly or 0
	int 80h				; call dat kernel
