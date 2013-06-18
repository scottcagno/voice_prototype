#!/bin/bash
sox -q -r 16000 -b 16 -c 1 -d a.flac silence 1 0.1 1% 1 0.3 1% 2>/dev/null
echo `curl -s --data-binary @a.flac --header 'Content-Type: audio/x-flac; rate=16000' 'https://www.google.com/speech-api/v1/recognize?client=chromium&lang="en-us"' | cut -d"," -f3 | sed 's/^.*utterance\":\"\(.*\)\"$/\1/g'`
rm a.flac

