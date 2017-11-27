mine: mine.o
	ld -o mine mine.o
mine.o: mine.asm
	nasm -f elf32 -o mine.o mine.asm
