polym: polym.o
	ld -o polym polym.o && objdump -D polym -M intel
polym.o: polym.asm
	nasm -f elf32 -o polym.o polym.asm
