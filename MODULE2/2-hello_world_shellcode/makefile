panda: panda.o
	ld -o panda panda.o && objdump -d panda -M intel
panda.o: panda.asm
	nasm -f elf32 -o panda.o panda.asm
