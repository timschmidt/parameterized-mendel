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


call = {}
scalar = {}
modules = {}
variables = {}
stack = []
def process(tokens,file_name):
	print file_name
	get_mod_name = 0 
	current_call = ''
	for i in t:
#		print i
		sl = len(stack)
		#for j in range(sl):
		#	print '-',
		#print i[1],
		if i[0] == 1:
		#	print 'call ' + str(i[1])
			if get_mod_name:
				print '\t'+i[1]
				get_mod_name = 0
				if modules.has_key(i[1]):
					modules[i[1]].append(file_name + ' line ' + str(i[2][0]))
				else:
					modules[i[1]] = [file_name + ' line ' + str(i[2][0])] 

			if i[1] == 'module':
				#print 'module ->'+i[1]
				get_mod_name = 1
				
			if call.has_key(i[1]):
				call[i[1]] = call[i[1]] + 1
			else:
				call[i[1]] = 1
			current_call = i[1]
		if i[0] == 2:
		#	print 'scalar ' + str(i[1])
			if scalar.has_key(i[1]):
				scalar[i[1]] = scalar[i[1]] + 1
			else:
				scalar[i[1]] = 1
		if i[0] == 51:
		#	if i[1] == '=':
		#		print 'assignment'
			if i[1] == '(':
		#		print 'stack add'
				stack.append(i)
			if i[1] == ')':
				tok = stack.pop()
		#		print 'pop' 
			if i[1] == '=':
				if variables.has_key(current_call):
					variables[current_call].append(file_name + ' line ' + str(i[2][0]))
				else:
					variables[current_call] = [file_name + ' line ' + str(i[2][0])] 
				

sha_path = '../part_sha.txt'
sha_dict =  {}
try:
        f = open(sha_path)
        li = f.readlines()
        f.close()
        for i in li:
                tmp = string.split(string.strip(i),',')
                sha_dict[tmp[0]] = tmp[1]
except:
        print 'no existing sums'

print 'Tokenizing scad files'
print 
print 'Module List'

k = sha_dict.keys()
for i in k:
	if i[-4:] == 'scad':
		t = tokenize_scad('../'+i)
		process(t,i)
	if i[-3:] == 'inc':
		t = tokenize_scad('../'+i)
		process(t,i)
#print call
#print 'Scalar ::\n\n'
#print scalar
print 
print 'Modules ::'
print 
k = modules.keys()
k.sort()
for i in k:
	if len(modules[i]) > 1:
		print 'duplicate module def ' + i 
		for j in modules[i]:
			print '\t' + j
#	else:
#		print 'single module def ' + i 
#		print '\t' + modules[i][0]

# get rid of internal varlables
print 
print 'Variables ::'
print 
del variables['r']
del variables['h']
del variables['v']
del variables['center']
del variables['fn']

v = variables.keys()
v.sort()
for i in v:
	if len(variables[i]) > 1:
		print 'duplicate variable def ' + i 
		for j in variables[i]:
			print '\t' + j

print 
print " Variable instance count ::"
print 
for i in v:
	if call.has_key(i):
		print i + ' : ' + str(call[i])
	else:
		print i + ' unreferenced'

#print scalar
print '\nend\n'
