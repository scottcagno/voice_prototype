#!/usr/bin/env python
# Copyright (c) 2013-Present, Scott Cagno
# All rights reserved. [BSD License]

import glob, json, os, sys

if __name__ == '__main__':
	print("Gathering config files...")
	cmdsmap={}
	for jsonfile in glob.iglob("conf/cmds/*.json"):
		print("Compiling [%s] into hashmap" % jsonfile.split('/')[-1])
		with open(jsonfile) as fd:
			json_text=fd.read().split()
			json_data=json.loads(''.join(json_text))
			cmdsmap.update(json_data)
	corpus=[]
	for key in cmdsmap.items():
		corpus.append(key)
	print("Creating [vocab.corpus] and writing keywords from hashmap") 
	with open("vocab.corpus", "w") as fd:
		for line in corpus:
			fd.write(line[0]+"\n")
	
	#print("Sending [vocab.corpus] to lm compiler, return and stage in [conf/lang]")
	#bash='''res=$(curl -s -L -H "Content-Type: multipart/form-data" -F "corpus=@vocab.corpus" -F "formtype=simple" http://www.speech.cs.cmu.edu/cgi-bin/tools/lmtool/run/); rm vocab.corpus; ref=$(echo $res | grep -oE 'title[^<>]*>[^<>]+' | cut -d'>' -f2 | sed -e "s/Index of//g" | tr -d ' '); sid=$(echo $res | grep -oE 'b[^<>]*>[^<>]+' | cut -d'>' -f2 | awk '/[0-9]/ { print $0 }' | head -1); curl -s -O http://www.speech.cs.cmu.edu$ref/TAR$sid.tgz; tar zxf TAR$sid.tgz; rm TAR$sid.tgz; mv *.dic conf/lang/dic; mv *.lm conf/lang/lm; rm $sid.*'''
	#os.system(bash)

	print("Running [corpus_uploader.sh]...")
	os.system("./corpus_uploader.sh")
	print("DONE")