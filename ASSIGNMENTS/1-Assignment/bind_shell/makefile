bind-shell: bind-shell.o
	ld -o bind-shell bind-shell.o
bind-shell.o: bind-shell.asm
	nasm -f elf32 -o bind-shell.o bind-shell.asm
