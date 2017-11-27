#!/usr/bin/env python
#
# Script name		: check-decode.py
# Author		: wetw0rk
# Version		: 1.0
# Created Following	: SLAE
# Descriptiom		: Just a quick dirty script to check if opcodes match.
#			  It's assumed that the provided shellcode is encoded.
#			  You simple check your decoding method here. Before a
#			  assembly decoder is made you should test decoding.
#

# color checking for easier to decipher output
class color:
	B = '\033[94m'
	E = '\033[0m'

# python objdump2shellcode.py -d <binary> -f nasm
# compare to the decoded original shellcode
decoded = [
	0xeb,0x18,0x5b,0x31,0xc0,0x88,0x43,0x09,
	0x89,0x5b,0x0a,0x89,0x43,0x0e,0xb0,0x0b,
	0x8d,0x1b,0x8d,0x4b,0x0a,0x8d,0x53,0x0e,
	0xcd,0x80,0xe8,0xe3,0xff,0xff,0xff,0x2f,
	0x62,0x69,0x6e,0x2f,0x62,0x61,0x73,0x68,
	0x41,0x44,0x45,0x41,0x44,0x42,0x45,0x45,
	0x46,
	]

# place encoded shellcode here
encoded = ("\xca\x39\x7a\x10\xe1\xa9\x62\x28\xa8\x7a\x2b\xa8\x62\x2f\x91\x2a\xac\x3a\xac\x6a"
"\x2b\xac\x72\x2f\xec\xa1\xc9\xc2\xde\xde\xde\x0e\x43\x48\x4f\x0e\x43\x40\x52\x49"
"\x60\x65\x64\x60\x65\x63\x64\x64\x67")

# result & prevous op stored here
result = []
ol_ops = []

# test decoding thoery here
for i in bytearray(encoded):
	# encoding
	b = i ^ 0xDE
	b = b | 0x00
	b = ~b
	# 4 checking
	result += b & 0xff,
	ol_ops += i,

for i in range(len(result)):
	if result[i] == decoded[i]:
		print "%sMATCH => Encoded OP: 0x%02x, Result OP: 0x%02x, Excepted OP: 0x%02x%s" % (
			color.B, ol_ops[i], result[i], decoded[i], color.E)
	else:
		print "FAIL! => Encoded OP: 0x%02x, Result OP: 0x%02x, Excepted OP: 0x%02x" % (
			ol_ops[i], result[i], decoded[i])
