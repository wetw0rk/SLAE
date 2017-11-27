not-decode: not-decode.o
	ld -o not-decode not-decode.o && objdump -D not-decode -M intel
not-decode.o: not-decode.asm
	nasm -f elf32 -o not-decode.o not-decode.asm
