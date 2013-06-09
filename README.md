VOICE
=====
Voice Operated Interpolated Coding Engine
-----------------------------------------

Getting Started
---------------
1) Add .json command files the the command directory.
2) Run 'compile_corpus.py' to have a corpus file auto generated for you based on your command files.
3) Edit 'parser.py' and specifically the 'parse_hyp' method to fine tune how your recognized speech is handled.
4) Run 'voice.py'.
5) Speak and be amazed.

Tips
----
1) Adjust your configuration files to account for words that may sound similiar. The more syllables the higher the accuracy, theoretically.
2) Consider using the NATO phonetic alphabet to spell words.
3) Prefix short utterances, and link phrases together with dashes so they get compiled as a single phrase in the language model.
