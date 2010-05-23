#!/usr/bin/python

import os,string,commands,sha,time

openscad_com = 'openscad'
pathd = '/'
export_folder = 'generated'
sha_path = 'part_sha.txt'

print 'Generate STL files for mendel'
print

## load sha sums 
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
stl_count = len(stl_files)
scad_count = len(scad_files)
total_count = stl_count + scad_count 

print str(stl_count) + ' stl files' 
print str(scad_count) + ' scad files' 
print str(int(((scad_count/float(total_count))*100))) + '% finished '
print

def changed(file_name,digest):
	if sha_dict.has_key(file_name):
		if digest == sha_dict[file_name]:
			return 0
		else:
			return 1	

	else:
		sha_dict[file_name] = digest
		return 1

def save_sums(sums):
	# save the sha sums for next time.
	f = open(sha_path,'w')
	k = sums.keys()
	for i in sums:
		f.write(str(i)+','+str(sums[i]))
		f.write('\n')
	f.close()

total = 0
for i in scad_files:
	f = open(i)
	d = f.read()
	f.close()
	s = sha.sha(d)
	if changed(i,s.hexdigest()):
		print i + '  has changed' 
		root_name = i[:-4]
		t = time.time()
		command = openscad_com +' -s '+export_folder + pathd + root_name+'stl '+i
		print i + ' building ... '
		commands.getoutput(command)
		save_sums(sha_dict)
		after = time.time()
		delta = after - t 
		print i + ' built in ' + str(int(delta)) + ' seconds'
		print 
		total = total + delta

print "total time =" + str(int(total))
	

