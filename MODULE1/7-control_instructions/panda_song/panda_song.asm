; Executable name       : panda_song
; Designed OS           : Linux (32-bit)
; Author                : wetw0rk
; Version               : 1.0
; Created Following     : SLAE
; Description           : A simple program that shows control instructions
;
; Build using these commands:
;       nasm -f elf32 -o panda_song.o panda_song.asm
;       ld -o panda_song panda_song.o
;

SECTION .data
	; https://www.youtube.com/watch?v=k-CX0SLJADg
	desiigner:
		db "  ____       _      _   _    ____       _",10
		db "U|  _ \ uU  / \  u | \ | |  |  _ \  U  / \  u",10
		db "\| |_) |/ \/ _ \/ <|  \| |>/| | | |  \/ _ \/",10
		db " |  __/   / ___ \ U| |\  |uU| |_| |\ / ___ \",10
		db " |_|     /_/   \_\ |_| \_|  |____/ u/_/   \_\",10
		db " ||>>_    \\    >> ||   \\,-.|||_    \\    >>",10
		db "(__)__)  (__)  (__)(_ )  (_/(__)_)  (__)  (__)",10

	LyricLen: EQU $-desiigner

SECTION .text

global _start

_start:
	jmp ChasingCodeine	; JMP unconditionally

MissMe:
	mov eax,0x10		; This will never execute since the
	xor ebx,ebx		; unconditional jump forces execution
				; to go to "ChasingCodeine" noice eh?

ChasingCodeine:
	mov eax,0x5		; This will serve as our loop counter :D
				; MOV 0x5 into EAX

AndTheFanta:
	push eax		; PUSH EAX onto the stack (save it)
	mov eax,4		; syscall for write
	mov ebx,1		; 1 or STDOUT
	mov ecx,desiigner	; the string/strings
	mov edx,LyricLen	; the length of the string
	int 80h

	pop eax			; POP value saved into EAX
	dec eax			; EAX should decrement by one
	jnz AndTheFanta		; until we hit 0 loop :D

	mov eax,0x1		; make that syscall we are done here!
	mov ebx,0		; cleanly exit after all we are clean?
	int 80h			; call that kernel!
