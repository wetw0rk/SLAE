decoder: decoder.o
	ld -o decoder decoder.o
decoder.o: decoder.asm
	nasm -f elf32 -o decoder.o decoder.asm
