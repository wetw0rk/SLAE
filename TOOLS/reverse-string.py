#!/usr/bin/env python
#
# Script name       : xor-encode.py
# Created following : SLAE
# Description       : simply reverses a string and converts the
#		      string into hexadecimal
# 


import sys

try:
	input = sys.argv[1]
except:
	print "Usage: %s <string>" % sys.argv[0]
	sys.exit()

print "String Length: %d" % (len(input))

string_list = [input[i:i+4] for i in range(0, len(input), 4)]

for item in string_list[::-1]:
	print item[::-1] + " : " + str(item[::-1].encode('hex'))
