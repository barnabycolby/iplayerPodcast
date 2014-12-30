#!/bin/bash
inputFile=$1
tmpFile=$inputFile.tmp
prefix="echo \""
suffix="\""

# First, escape any backslashes
sed -e 's/\\/\\\\/g' $inputFile > $tmpFile
cat $tmpFile > $inputFile

# Then, add the echos
sed -e "s/^/$prefix/" $inputFile > $tmpFile
sed -e "s/$/$suffix/" $tmpFile > $inputFile

rm $tmpFile
