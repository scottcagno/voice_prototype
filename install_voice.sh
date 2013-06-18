#!/bin/bash
# Copyright (c) 2013-Present, Scott Cagno
# All rights reserved. [BSD License]

if [[ $1 = 'clean' ]]; then
	sudo apt-get install git
	git clone https://github.com/scottcagno/voice.git
	./install_dependencies.py
fi
echo "alias voice='cd `pwd`'" >> ~/.bashrc
echo "VOICE INSTALLER COMPLETE, RESTARTING BASH..."
bash