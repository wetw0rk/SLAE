; Executable name       : math
; Designed OS           : Linux (32-bit)
; Author                : wetw0rk
; Version               : 1.0
; Created Following     : SLAE
; Description           : A simple program that shows how arithmetic
;                         in assembly works.
;
; Build using these commands:
;       nasm -f elf32 -o math.o math.asm
;       ld -o math math.o
;
; How to run and use this program (intention):
;       gdb -q ./math
;

SECTION .data

	buff1: db 0x00
	buff2: dw 0x0000
	buff3: dd 0x00000000

SECTION .text

global _start

_start:
	; Example of register based addition
	add al,0x10			; ADD 0x10 to EAX
	add al,0x10			; ADD 0x10 to EAX (EAX should = 0x20)

	mov ax,0x1337			; MOV 0x1337 into EAX
	add ax,0x1911			; ADD 0x1911 into EAX (EAX should = 0x2c48)

	mov eax,0xffffffff		; MOV 0xffffffff into EAX
	add eax,0x10			; ADD 0x10 to the value in EAX (this will raise CF)

	; Example of memory based addition
	xor eax,eax			; zero out the register for example
	add byte [buff1],0x20		; ADD 1 byte (0x20) to [buff1]
	add byte [buff1],0x10		; ADD 1 byte (0x10) to [buff1] ([buff1] should = 0x30)

	add word [buff2],0x1111		; ADD 2 bytes to [buff2]
	add word [buff2],0x3333		; ADD 2 bytes to [buff2] ([buff2] should = 0x4444)

	mov dword [buff3],0xffffffff	; MOV 0xffffffff to [buff3]
	add dword [buff3],0x10		; ADD 0x10*4 to [buff3] ([buff3] should = 0x0000000f)
					; and the carry flag should be set.

	; Example of setting,clearing, and complement with the CF
	clc				; clear the CF
	stc				; set the CF
	cmc				; complement the CF (meaning if CF is set, clear it
					; or if CF is not set, set it)

	; Example of adding with the carry flag
	xor eax,eax                     ; zero out the register for example
	stc				; set the CF flag
	adc al,0x20			; ADD 0x20 to EAX if the CF is set (it is) add another 1
	stc				; set the CF flag
	adc al,0x10			; ADD 0x10 to EAX if the CF is set +1 (EAX should = 0x32)

	mov ax,0x1111			; MOV 0x1111 to EAX or AX if you want to be specific
	stc				; set the CF
	adc ax,0x2222			; if CF set ADD 0x2222 to AX. EAX should = 0x3334

	mov eax,0xffffffff		; MOV 0xffffffff into EAX
	stc				; set the CF
	adc eax,0x10			; if CF set ADD 0x10 into EAX

	; Example of subtraction
	mov eax,10			; MOV 10 into EAX
	sub eax,5			; SUB-tract 5 from EAX. EAX should now = 5
	stc				; set the CF
	sbb eax,4			; SUB-tract 4 from EAX. If the CF is set subtract
					; 1 ontop of whatever will be subtracted. Meaning
					; this will subtract 5 from EAX

	; Example of the increment and decrement instructions
	inc eax				; INC-rement EAX by 1
	dec eax				; DEC-rement EAC by 1

	; exit the program cleanly as always
	mov eax,1			; exit() syscall
	mov ebx,0			; 0 for clean exit
	int 80h				; call the kernel

