egg: egg.o
	ld -o egg egg.o
egg.o: egg.asm
	nasm -f elf32 -o egg.o egg.asm
