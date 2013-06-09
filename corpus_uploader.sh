#!/bin/bash
# Copyright (c) 2013-Present, Scott Cagno
# All rights reserved. [BSD License]

# ------------------------------------------
# THIS BASH SCRIPT UPLOADS A CORPUS FILE TO 
# THE CMU ONLINE LANGUAGE MODELING GENERATOR.
# IT WILL RETURN AND STAGE THE GENERATED 
# LANGUAGE MODEL AND DICTIONARY FILES IN THE
# SPECIFIED DIRECTORY (LANGDIR).
# ------------------------------------------

# DIRECTORY WHERE THE RETURNED LANGAUGE FILES WILL BE STAGED
LANGDIR="conf/lang"

# SETUP URL 
URL="http://www.speech.cs.cmu.edu"

# MAKE HTTP POST REQUEST TO UPLOAD VOCAB.CORPUS FILE. (SAVE HTTP RESPONSE IN $RES VAR)
RES=`curl -sL -H "Content-Type: multipart/form-data" -F "corpus=@vocab.corpus" -F "formtype=simple" $URL/cgi-bin/tools/lmtool/run/` 

# CLEAN UP CORPUS FILE, WE NO LONGER NEED IT.
rm vocab.corpus

# ECHO THE CONTENTS OF THE SAVED HTTP RESPONSE, PARSE OUT THE UNIQUE REFERENCES URL. (SAVE IN $REF)
REF=`echo $RES | grep -oE 'title[^<>]*>[^<>]+' | cut -d'>' -f2 | sed -e "s/Index of//g" | tr -d ' '`

# ECHO THE CONTENTS OF THE SAVED HTTP RESPONSE, PARSE OUT THE UNIQUE SERIAL ID. (SAVE IN $SID)
SID=`echo $RES | grep -oE 'b[^<>]*>[^<>]+' | cut -d'>' -f2 | awk '/[0-9]/ { print $0 }' | head -1`

# MAKE HTTP GET REQUEST TO DOWNLOADS THE GENERATED LANGUAGE FILES. 
curl -sO $URL$REF/TAR$SID.tgz

# UNPACK AND CLEANUP TARBALL.
tar zxf TAR$SID.tgz
rm TAR$SID.tgz

# STAGE IMPORTANT FILES IN SPECIFIED $LANGDIR 
mv *.dic $LANGDIR/dic
mv *.lm $LANGDIR/lm

# CLEAN UP THE REMAINING UNWANTED FILES.
rm $SID.*