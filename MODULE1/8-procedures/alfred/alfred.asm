; Executable name       : alfred
; Designed OS           : Linux (32-bit)
; Author                : wetw0rk
; Version               : 1.0
; Created Following     : SLAE
; Description           : A simple program that shows procedures
;
; Build using these commands:
;       nasm -f elf32 -o alfred.o alfred.asm
;       ld -o alfred alfred.o
;

SECTION .data

	; https://www.youtube.com/watch?v=efHCdKb5UWc
	qoute:
		db "Because some men aren't looking for anything logical, like money."
		db "They can't be bought, bullied, reasoned, or negotiated with. Some"
		db "men just want to watch the world burn.",10

	qtlen: EQU $-qoute

SECTION .text

global _start

alfred:
	push ebp		; save the frame pointer
	mov ebp,esp		; MOV ESP address into EBP

	mov eax,4		; make the syscall to write()
	mov ebx,1		; write to fd 1 or STDOUT
	mov ecx,qoute		; place string
	mov edx,qtlen		; place length
	int 80h			; call the kernel

	leave			; MOV EBP back to ESP and POP EBP
	ret			; return

_start:
	mov ecx,1		; loop counter (yes once)

stdout:
	pushad			; PUSH all GP registers
	pushfd			; PUSH all flags

	call alfred		; CALL our procedure

	popfd			; (what is pushed must ne popped) POP flags
	popad			; POP GP registers

	loop stdout		; until 0 LOOP

end:
	mov eax,1		; make the exit() syscall
	mov ebx,0		; exit cleanly
	int 80h			; call that kernel
