dog: dog.o
	gcc -o dog dog.o
dog.o:dog.asm
	nasm -f elf32 -o dog.o dog.asm
