alfred: alfred.o
	ld -o alfred alfred.o
alfred.o: alfred.asm
	nasm -f elf32 -o alfred.o alfred.asm
