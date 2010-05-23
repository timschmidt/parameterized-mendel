#!/usr/bin/python

import os,string,commands,sha,time

openscad_com = 'openscad'
pathd = '/'
export_folder = 'generated'
try:
	os.stat(export_folder)
	print export_folder + ' folder exists'
except:
	os.mkdir(export_folder)
	print 'make folder'
scad_files = []
stl_files = []
li = os.listdir('./')
for i in li:
	if i[-4:]  == 'scad' :
		scad_files.append(i)
	if i[-3:]  == 'stl' :
		stl_files.append(i)

print scad_files
print stl_files
print len(stl_files)
print len(scad_files)

for i in scad_files:
	root_name = i[:-4]
	t = time.time()
	command = openscad_com +' -s '+export_folder + pathd + root_name+'stl '+i
	print command
	commands.getoutput(command)
	after = time.time()
	print after - t 
