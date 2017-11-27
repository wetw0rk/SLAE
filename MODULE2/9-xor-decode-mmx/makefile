xor-mmx: xor-mmx.o
	ld -o xor-mmx xor-mmx.o && objdump -D xor-mmx -M intel
xor-mmx.o: xor-mmx.asm
	nasm -f elf32 -o xor-mmx.o xor-mmx.asm
