#!/usr/bin/env python
# Copyright (c) 2013-Present, Scott Cagno
# All rights reserved. [BSD License]

import glob, json, os, sys

if __name__ == '__main__':
	print("Gathering config files...")
	cmdsmap={}
	scopefs=[]
	for jsonfile in glob.iglob("conf/cmds/*.json"):
		print("Compiling [%s] into hashmap" % jsonfile.split('/')[-1])
		with open(jsonfile) as fd:
			scopefs.append(fd.name.split('/')[-1].split('.')[0].upper())
			json_text=fd.read().split()
			json_data=json.loads(''.join(json_text))
			cmdsmap.update(json_data)
	corpusf=[]
	for key in cmdsmap.items():
		corpusf.append(key)
	print("Creating [vocab.corpus] and writing keywords from hashmap") 
	with open("vocab.corpus", "w") as fd:
		for line in corpusf:
			fd.write(line[0]+"\n")
		for line in scopefs:
			fd.write(line+"\n")
	
	print("Running [corpus_uploader.sh]...")
	os.system("./corpus_uploader.sh")
	print("DONE")