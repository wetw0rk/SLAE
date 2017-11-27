execve3: execve3.o
	ld -o execve3 execve3.o && objdump -D execve3 -M intel
execve3.o: execve3.asm
	nasm -f elf32 -o execve3.o execve3.asm
