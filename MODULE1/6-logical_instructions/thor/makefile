thor: thor.o
	ld -o thor thor.o
thor.o: thor.asm
	nasm -f elf32 -o thor.o thor.asm
