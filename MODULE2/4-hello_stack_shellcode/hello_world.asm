; Executable name	: hello_world
; Designed OS		: Linux (32-bit)
; Author		: wetw0rk
; Version		: 1.0
; Created Following	: SLAE
; Description		: Shellcode that prints a string
;			  onto the screen. using the stack.
;
; Build using these commands:
;	nasm -f elf32 -o hello_world.o hello_world.asm
;	ld -o hello_world hello_world.o
;	objdump -d hello_world -M intel

SECTION .text

global _start

_start:
	xor eax,eax			; zero out (remove nulls)
	mov al,4			; syscall for write()
	xor ebx,ebx			; zero out
	mov bl,1			; fd == 1 or STDOUT
	xor edx,edx			; zero out
	push edx			; PUSH 4 nulls on the stack (EDX was xor-ed)

	push 0x0a646c72			; PUSH our hello world onto the stack
	push 0x6f57206f			; this is done backwards. "Hello World"
	push 0x6c6c6548			; starts low memory to high memory. The
					; stack grows from High memory to low
					; memory.

	mov ecx,esp			; Place the top of the stack in ECX
					; remember ESP points to the top of
					; stack. Meaning ECX will contain
					; our string, since it was the last
					; thing pushed onto the stack

	mov dl,12			; the length of our string
	int 80h				; call the kernel

	xor eax,eax			; zero out
	mov al,1			; syscall for exit()
	xor ebx,ebx			; zero out (0 == clean)
	int 80h				; call the kernel
