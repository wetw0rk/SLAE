exit: exit.o
	ld -o exit exit.o && objdump -d exit -M intel
exit.o: exit.asm
	nasm -f elf32 -o exit.o exit.asm
