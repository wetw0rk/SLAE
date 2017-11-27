execve2: execve2.o
	ld -o execve2 execve2.o && objdump -D execve2 -M intel
execve2.o: execve2.asm
	nasm -f elf32 -o execve2.o execve2.asm
