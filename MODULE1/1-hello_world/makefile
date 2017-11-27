panda: panda.o
	ld -o panda panda.o
panda.o: panda.asm
	nasm -f elf32 -o panda.o panda.asm
