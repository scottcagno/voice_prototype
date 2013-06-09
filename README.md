### VOICE :: Voice Operated Interpolated Coding Engine

______________________________________________________

#### Getting Started

  * Add .json command files the the command directory.
  
  * Run 'compile_corpus.py' to have a corpus file auto generated for you based on your<br>
    command files.
  
  * Edit 'parser.py' and specifically the 'parse_hyp' method to fine tune how your recog-<br>
    nized speech is handled.
  
  * Run 'voice.py'.
  
  * Speak and be amazed.

#### Tips
  * Adjust your configuration files to account for words that may sound similiar. The more<br>
    syllables the higher the accuracy, theoretically.
  
  * Consider using the NATO phonetic alphabet to spell words.
  
  * Prefix short utterances, and link phrases together with dashes so they get compiled as<br>
    a single phrase in the language model.
