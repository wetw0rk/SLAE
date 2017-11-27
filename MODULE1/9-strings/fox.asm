; Executable name       : fox
; Designed OS           : Linux (32-bit)
; Author                : wetw0rk
; Version               : 1.0
; Created Following     : SLAE
; Description           : A simple program that shows how strings work
;
; Build using these commands:
;       nasm -f elf32 -o fox.o fox.asm
;       ld -o fox fox.o
;

SECTION .data

	source: db "Welcome home",10
	srclen: equ $-source

	equaly: db "Strings In Snyc (=)",10
	equlen: equ $-equaly

	equaln: db "Strings Not in Sync (!=)",10
	lenequ: equ $-equaln

SECTION .bss

	buffer: resb 100

SECTION .text

global _start

_start:
	; Example of copying a string from source to a destination buffer
	mov ecx,srclen			; MOV strlen into ECX repeat loop counter
	lea esi,[source]		; load the strings address into ESI
	lea edi,[buffer]		; load the empty buffer into EDI
	cld				; clear the CF flag
	rep movsb			; repeat for len(ECX) placing a byte into
					; the empty buffer.

	mov eax,4			; syscall to write()
	mov ebx,1			; write to STDOUT or fd 1
	mov ecx,buffer			; our buffer is no longer empty! (contains string)
	mov edx,srclen			; the length of string
	int 80h				; call the kernel troll

	; Example of comparing the two strings
	mov ecx,srclen			; MOV strlen into ECX for repeat counter
	lea esi,[source]		; load the strings address into ESI
	lea edi,[buffer]		; load the buffers address into EDI
	rep cmpsb			; REP-eat if equal. If equal ZF is set. else
					; ZF is not set

	jz SetEqual			; if both strings are equal ZF has been set to
					; JMP to set_equal

	mov ecx,equaln			; the ZF flag was not set meaning that strings are !=
					; load up our string
	mov edx,lenequ			; not the length (this is in prep for printing the message)
	jmp print			; "mission failed we'll get em next time" - some guy in C.O.D.

SetEqual:
	mov ecx,equaly			; load up our string
	mov edx,equlen			; and the length

print:
	mov eax,4			; syscall for write()
	mov ebx,1			; STDOUT or fd 1
	int 80h				; call that kernel!

	mov eax,1			; syscall for exit()
	mov ebx,0			; cleanly exit or 0
	int 80h				; call the kernel
