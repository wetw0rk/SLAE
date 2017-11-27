reverse-shell: reverse-shell.o
	ld -o reverse-shell reverse-shell.o
reverse-shell.o: reverse-shell.asm
	nasm -f elf32 -o reverse-shell.o reverse-shell.asm
