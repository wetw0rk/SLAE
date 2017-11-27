exit2: exit2.o
	ld -o exit2 exit2.o && objdump -d exit2 -M intel
exit2.o: exit2.asm
	nasm -f elf32 -o exit2.o exit2.asm
