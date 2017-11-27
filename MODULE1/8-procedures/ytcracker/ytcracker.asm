; Executable name       : ytcracker
; Designed OS           : Linux (32-bit)
; Author                : wetw0rk
; Version               : 1.0
; Created Following     : SLAE
; Description           : A simple program that shows procedures
;
; Build using these commands:
;       nasm -f elf32 -o ytcracker.o ytcracker.asm
;       ld -o ytcracker ytcracker.o
;

SECTION .data

	; https://www.youtube.com/watch?v=6UJpupxhdEw
	chorus:
		db "It's a spammers paradise",10
		db "Where everyone has an email and checks it twice",10
		db "Buy anything without seeing the price",10
		db "And send money to Nigeria because the prince sounds nice",10

	chrlen: equ $-chorus

SECTION .text

global _start

ytcracker:
	mov eax,4			; make that write() syscall
	mov ebx,1			; STDOUT or fd = 1
	mov ecx,chorus			; our string
	mov edx,chrlen			; string len
	int 80h				; call the kernel
	ret				; return to where we were called

_start:
	mov ecx,10			; loop counter

thebest:
	push ecx			; PUSH and save our value onto the stack
	call ytcracker			; CALL our label
	pop ecx				; POP our saved value onto ECX
	loop thebest			; LOOP until zero (automatically decrement ECX)

exit:
	mov eax,1			; make the exit() syscall
	mov ebx,0			; cleanly exit the program
	int 80h				; call the kernel
