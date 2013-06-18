#!/bin/bash
# Copyright (c) 2013-Present, Scott Cagno
# All rights reserved. [BSD License]

if [ "`arecord --list-devices | grep USB\ Audio`" ]; then
	echo "USB MIC FOUND, SETTING AS DEFAULT MIC..."
	sleep 2
	xdotool key super
	sleep 1
	xdotool type 'sound'
	xdotool key Down Down Return
	sleep 1
	xdotool key Tab Right
	sleep 1
	xdotool key Tab Down 
	xdotool key Down Return
	xdotool key alt+F4
	echo "USB MIC SET AS DEFAULT INPUT SOURCE."
else
	echo "USB MIC NOT FOUND, EXITING SOUND SETUP."
fi

