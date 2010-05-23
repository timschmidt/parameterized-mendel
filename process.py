#!/usr/bin/python

import os,string,commands,sha,time

openscad_com = 'openscad'
pathd = '/'
export_folder = 'generated'
sha_path = 'part_sha.txt'


## load sha sums 
sha_dict =  {}
f = open(sha_path)
li = f.readlines()
f.close()
for i in li:
	tmp = string.split(string.strip(i),',')
	sha_dict[tmp[0]] = tmp[1]

# make export folder
try:
	os.stat(export_folder)
except:
	os.mkdir(export_folder)
	print 'make folder'

# scan for the files 
scad_files = []
stl_files = []
li = os.listdir('./')
for i in li:
	if i[-4:]  == 'scad' :
		scad_files.append(i)
	if i[-3:]  == 'stl' :
		stl_files.append(i)

#print scad_files
#print stl_files
#print len(stl_files)
#print len(scad_files)

def changed(file_name,digest):
	if sha_dict.has_key(file_name):
		if digest == sha_dict[file_name]:
			return 0
		else:
			return 1	

	return 1 
sums = []
	
for i in scad_files:
	f = open(i)
	d = f.read()
	f.close()
	s = sha.sha(d)
	sums.append([i,s.hexdigest()])
	if changed(i,s.hexdigest()):
		root_name = i[:-4]
		t = time.time()
		command = openscad_com +' -s '+export_folder + pathd + root_name+'stl '+i
		print command
		commands.getoutput(command)
		after = time.time()
		print after - t 

f = open(sha_path,'w')
for i in sums:
	f.write(str(i[0])+','+str(i[1]))
	f.write('\n')
f.close()
