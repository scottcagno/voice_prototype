#!/usr/bin/env python
# Copyright (c) 2013-Present, Scott Cagno
# All rights reserved. [BSD License]

import gobject, signal, os
gobject.threads_init()
from parser import Parser

if __name__ == '__main__':
	voice = Parser()
	loop = gobject.MainLoop()
	signal.signal(signal.SIGINT, signal.SIG_DFL)
	voice.run()
	print("PID: %s" % os.getpid())
	try:
		loop.run()
	except:
		loop.quit()
		sys.exit()
