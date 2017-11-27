execve: execve.o
	ld -o execve execve.o && objdump -D execve -M intel
execve.o: execve.asm
	nasm -f elf32 -o execve.o execve.asm
