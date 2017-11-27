xor-decoder2: xor-decoder2.o
	ld -o xor-decoder2 xor-decoder2.o && objdump -D xor-decoder2 -M intel
xor-decoder2.o: xor-decoder2.asm
	nasm -f elf32 -o xor-decoder2.o xor-decoder2.asm
