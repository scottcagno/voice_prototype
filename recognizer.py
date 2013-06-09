#!/usr/bin/env python
# Copyright (c) 2013-Present, Scott Cagno
# All rights reserved. [BSD License]

import pygst, gst, os, gobject

# working directory
pwd = os.path.dirname(os.path.abspath(__file__))

class Recognizer(gobject.GObject):
	
	__gsignals__ = {
		'finished' : (gobject.SIGNAL_RUN_LAST, gobject.TYPE_NONE, (gobject.TYPE_STRING,))
	}
	
	def __init__(self, lm, dic):
		gobject.GObject.__init__(self)
		self.commands = {}
		audiopipe = [
			'autoaudiosrc',
			'audioconvert',
			'audioresample',
			'vader name=vad',
			'pocketsphinx name=asr',
			'appsink sync=false'
		]
		audiopipe = ' ! '.join(audiopipe)
		self.pipeline = gst.parse_launch(audiopipe)
		# audo speech recognition
		asr = self.pipeline.get_by_name('asr')
		asr.connect('result', self.result)
		asr.set_property('lm', lm)
		asr.set_property('dict', dic)
		asr.set_property('configured', True)
		# voice activity detector
		self.vad = self.pipeline.get_by_name('vad')
		self.vad.set_property('auto-threshold', True)

	def listen(self):
		self.pipeline.set_state(gst.STATE_PLAYING)

	def pause(self):
		self.vad.set_property('silent', True)
		self.pipeline.set_state(gst.STATE_PAUSED)

	def result(self, asr, text, uttid):
		self.emit('finished', text)
