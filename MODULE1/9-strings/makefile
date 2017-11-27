fox: fox.o
	ld -o fox fox.o
fox.o: fox.asm
	nasm -f elf32 -o fox.o fox.asm
