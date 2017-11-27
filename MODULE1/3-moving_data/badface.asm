; Executable name       : badface
; Designed OS           : Linux (32-bit)
; Author                : wetw0rk
; Version               : 1.0
; Created Following     : SLAE
; Description           : A simple program that demonstrates moving data.
;			  This program is 100% designed to be ran under
;			  (gdb) so do not just run it willy nilly. Step
;			  through each instruction.
;
; Build using these commands:
;       nasm -f elf32 -o badface.o badface.asm
;       ld -o badface badface.o
;
; How to run and use this program (intention):
;	gdb -q ./badface
;

SECTION .data

	CDC: db 0xde, 0xad, 0xbe, 0xef, 0xfe, 0xee, 0xee, 0xed

SECTION .bss

SECTION .text

global _start

_start:
	; Example of MOV immediate data to register
	mov eax,0xbadfaced		; MOV 0xbadfaced into EAX
	mov al,0xef			; MOV 0xaf into AL. EAX should now be 0xbadfacef
	mov ah,0xbe			; MOV 0xbe into AH. EAX should now be 0xbadfbeef
	mov ax,0xeeed			; MOV 0xdead into AX. EAX should now be 0xbadfeeed

	; Example of MOV register to register
	mov ebx, eax			; MOV EAX (0xbadfeeed) into EBX
	mov cl, al			; MOV AL(0xed) into CL
	mov ch, ah			; MOV AH(0xee) into CH. ECX should now contain (0xeeed)
	mov cx, ax			; MOV AX(0xeeed) into CX. ECX should now contain (0xeeed)
	mov eax, 0			; zero out for next example
	mov ebx, 0			; zero out for next example
	mov ecx, 0			; zero out for next example

	; Example of MOV from memory into register
	mov al,[CDC+1]			; MOV 1 byte from [CDC+1] to AL. EAX should contain 0xad
	mov ah,[CDC]			; MOV 1 byte from [CDC] to AH. EAX should contain 0xdead
	mov bx,[CDC]			; MOV 2 bytes from [CDC] to BX. EBX should contain 0xadde
	mov ecx,[CDC]			; MOV 4 bytes from [CDC] to ECX. ECX should contain 0xefbeadde

	; Example of MOV from register into memory
	mov eax,0x1337cafe		; MOV 0x1337cafe into EAX
	mov byte [CDC],al		; replace first byte in [CDC] with 0xfe
	mov word [CDC],ax		; replace first two bytes in [CDC] with 0xfeca
	mov dword [CDC],eax		; replace first 4 bytes in [CDC] with 0xfeca3713

	; Example of MOV immediate value into memory
	mov dword [CDC],0xefbe3713	; MOV 0x1337beef into CDC

	; Example of loading effective address
	lea eax,[CDC]			; EAX should now contain CDC's address
	lea ebx,[eax]			; EBX should now contain CDC's address

	; Example of x-change lmao
	mov eax,0xbeefcafe		; MOV 0xbeefcafe into EAX
	mov ebx,0xbeeeeeef		; MOV 0xbeeeeeef into EBX
	xchg eax, ebx			; XCHG EAX and EBX (swap em)

	; exit the program elegantly
	mov eax,1			; syscall for exit()
	mov ebx,0			; exit cleanly or 0
	int 80h				; call the kernel
