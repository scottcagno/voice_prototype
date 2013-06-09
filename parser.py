#!/usr/bin/env python
# Copyright (c) 2013-Present, Scott Cagno
# All rights reserved. [BSD License]

import glob, subprocess, json, sys
from recognizer import Recognizer

class Parser(object):

	def __init__(self):
		self.init_commands()
		self.continuous_listen = True
		self.recognizer = Recognizer("conf/lang/lm", "conf/lang/dic")
		self.recognizer.connect('finished', self.parse_hyp)

	def init_commands(self):
		self.commands = {}
		for jsonfile in glob.iglob("conf/cmds/*.json"):
			with open(jsonfile) as fd:
				json_text = fd.read().split()
				json_data = json.loads(''.join(json_text))
				self.commands.update(json_data)

	def parse_hyp(self, recognizer, hyp):
		hyp = hyp.split(' ')
		self.display_parse_data(recognizer, hyp)

	def display_parse_data(self, recognizer, hyp):
		print("-------\nHYPOTHESIS: %s\n-------" % hyp)
		for cmd in hyp:
			sys.stdout.write("COMMAND: %s" % cmd)
			if self.commands.has_key(cmd):
				print(" :: ACTION FOUND: %s" % ', '.join(self.commands[cmd]))			
			else:
				print(" :: NO ACTION FOUND!!")
		print("-------")		

	def run(self):
		self.recognizer.listen()