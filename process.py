#!/usr/bin/python

import os,string,commands 

openscad_com = 'openscad'

scad_files = []
li = os.listdir('./')
for i in li:
	if i[-4:]  == 'scad' :
		scad_files.append(i)

print scad_files
for i in scad_files:
	root_name = i[:-4]
	command = openscad_com +' -s '+root_name+'stl '+i
	print command
	commands.getoutput(command)

