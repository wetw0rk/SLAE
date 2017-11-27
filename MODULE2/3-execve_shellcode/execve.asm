; Executable name       : execve
; Designed OS           : Linux (32-bit)
; Author		: wetw0rk
; Version               : 1.0
; Created Following     : SLAE
; Description           : An example of execve usage in shellcode
;
; Build using these commands:
;       nasm -f elf32 -o execve.o execve.asm
;       ld -o execve execve.o
;       objdump -D execve -M intel
;

SECTION .text

global _start

_start:

	jmp short call_shell		; short jump to call_shell

shell:
	pop ebx				; POP the string address into EBX

	xor eax,eax			; zero out EAX for NULLS
	mov byte [ebx+9],al		; MOV a null into EBX at offset 9,
					; meaning A = 0x00. So the prompt looks
					; like so: "/bin/bash0DEADBEEF"

	mov dword [ebx+10],ebx		; MOV address EBX into EBX offset 10,
					; Meaning DEAD = <EBX ADDR>. So prompt
					; looks like so: "/bin/bash0ADDRBEEF"

	mov dword [ebx+14],eax		; EAX was xor-ed, so at offset 14
					; place NULLS. So the prompt looks
					; like so "/bin/bash0ADDR0000"

	mov al,11			; make the execve() syscall
	lea ebx,[ebx]			; load "/bin/bash" from EBX into EBX
	lea ecx,[ebx+10]		; load EBX address into ECX
	lea edx,[ebx+14]		; load NULLS into EDX
	int 80h				; call the kernel

call_shell:
	call shell			; call shell label
	prompt db "/bin/bashADEADBEEF"	; address gets saved to stack
