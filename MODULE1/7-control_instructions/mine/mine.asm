; Executable name       : mine
; Designed OS           : Linux (32-bit)
; Author                : wetw0rk
; Version               : 1.0
; Created Following     : SLAE
; Description           : A simple program that shows control instructions
;
; Build using these commands:
;       nasm -f elf32 -o mine.o mine.asm
;       ld -o mine mine.o
;

SECTION .data

	birds: db "mine",10
	minel: equ $-birds

	q: db "Do you remmember where this is from?",10
	ql: equ $-q

SECTION .text

global _start

_start:
	mov eax,4			; syscall for write()
	mov ebx,1			; STDOUT or fd = 1
	mov ecx,q			; message string
	mov edx,ql			; message length
	int 80h				; to kernel land!

next:
	mov ecx,15			; this will serve as a loop counter
	jmp printit			; unconditional JMP

never: 					; this would never execute due to JMP

printit:
	push ecx			; PUSH ECX onto the stack for safe keeping ;)

	mov eax,4			; syscall for write()
	mov ebx,1			; STDOUT or fd = 1
	mov ecx,birds			; message string
	mov edx,minel			; message length
	int 80h				; to kernel land!

	pop ecx				; POP the saved value back into ECX
	loop printit			; LOOP back and decrement ECX by 1

exit:
	mov eax,1			; syscall for exit
	mov ebx,0			; cleanly exit 0
	int 80h				; call the kernel

