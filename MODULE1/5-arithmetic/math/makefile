math: math.o
	ld -o math math.o
math.o: math.asm
	nasm -f elf32 -o math.o math.asm
