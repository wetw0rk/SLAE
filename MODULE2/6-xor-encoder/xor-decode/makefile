xor-decoder: xor-decoder.o
	ld -o xor-decoder xor-decoder.o && objdump -D xor-decoder -M intel
xor-decoder.o: xor-decoder.asm
	nasm -f elf32 -o xor-decoder.o xor-decoder.asm
