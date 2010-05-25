#!/usr/bin/python 

# 201005251608
# simon kirkby
# tigger@interthingy.com
# GPL2+

# Openscad cleaner

import tokenize,os,string

def tokenize_scad(scad_file):
	f = open(scad_file)
	tok = tokenize.generate_tokens(f.readline)
	tokens = []
	for i in tok:
		tokens.append(i)
	f.close
	return tokens

t = tokenize_scad('../z-pulley.scad')
call = {}
scalar = {}
stack = []
for i in t:
	#print i
	sl = len(stack)
	for j in range(sl):
		print '-',
	if i[0] == 1:
		print 'call ' + str(i[1])
		if call.has_key(i[1]):
			call[i[1]] = call[i[1]] + 1
		else:
			call[i[1]] = 1
	if i[0] == 2:
		print 'scalar ' + str(i[1])
		if scalar.has_key(i[1]):
			scalar[i[1]] = scalar[i[1]] + 1
		else:
			scalar[i[1]] = 1
	if i[0] == 51:
		if i[1] == '=':
			print 'assignment'
		if i[1] == '(':
			print 'stack add'
			stack.append(i)
		if i[1] == ')':
			tok = stack.pop()
			print 'pop' 

print call
print 'Scalar ::\n\n'
print scalar
