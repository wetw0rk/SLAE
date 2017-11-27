; Executable name       : thor
; Designed OS           : Linux (32-bit)
; Author                : wetw0rk
; Version               : 1.0
; Created Following     : SLAE
; Description           : A simple program that shows how logical
;			  operators/instructions work. Thor sounds
;			  like XOR!
;
; Build using these commands:
;       nasm -f elf32 -o thor.o thor.asm
;       ld -o thor thor.o
;
; How to run and use this program (intention):
;       gdb -q ./thor
;

SECTION .data

	v1: db 0xaa
	v2: dw 0xbbcc
	v3: dd 0xdeadbeef

SECTION .text

global _start

_start:
	; AND example
	mov al,0x10			; MOV 0x10 into AL
	and al,0x01			; AND will result in a zero. This is easy to
					; understand by viewing the AND truth table.

	and byte [v1],0xaa		; AND will result in 0xaa. The bit position gives this
					; result. Once again check the truth table.

	and word [v2],0x1122		; AND will result in 0x1100 again check the table :)

	; OR example
	mov al,0x10			; MOV 0x10 into AL
	or al,0x01			; AL = 11 this is pretty direct. If it does not make sense
					; check the truth table

	or byte [v1],0xaa		; v1 will be 0xaa for similiar reasons

	mov eax,0			; zero out eax
	or eax,0x0			; 0 or 0 = 0. Very clear.

	; XOR example
	xor dword [v3],0xdeadbeef	; zero out v3 since they are = to each other
	xor dword [v3],0xdeadbeef	; since no longer the same v3 will contain 0xdeadbeef

	; NOT example
	mov eax,0xffffffff		; MOV 0xffffffff into EAX
	not eax				; NOT will make EAX zero since 1 will now be 0.
					; if confusing check truth table!
	not eax				; NOT will make EAX 0xffffffff

	mov eax,1			; dat exit() syscall
	mov ebx,0			; exit cleanly or x
	int 80h				; call the kernel
