hello_world: hello_world.o
	ld -o hello_world hello_world.o && objdump -d hello_world -M intel
hello_world.o: hello_world.asm
	nasm -f elf32 -o hello_world.o hello_world.asm
