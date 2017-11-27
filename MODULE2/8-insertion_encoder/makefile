execve4: execve4.o
	ld -o execve4 execve4.o && objdump -D execve4 -M intel
execve4.o: execve4.asm
	nasm -f elf32 -o execve4.o execve4.asm
