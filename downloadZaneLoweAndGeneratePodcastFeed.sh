#!/bin/bash

# Checks if an processedPids contains an element
containsElement () {
	local e
	for e in "${@:2}"; do [[ "$e" == "$1" ]] && return 0; done
	return 1
}

# Write the start time
echo -n "Script started at: "
date '+%A %d %B %Y %X'

# Read the config file
configFile=./podcastFeed.cfg
echo -n "Reading config....."
source $configFile
echo "Done."

# Redirect all program output to the logfile
echo -n "Opening FIFO pipe....."
mkfifo $nameOfFilePipe
echo "Done."
echo -n "Piping output to logfile as well as stdout....."
tee $logFile < $nameOfFilePipe &
teepid=$!
exec > $nameOfFilePipe 2>&1
echo "Done."

# Clear the log
> $logFile

# Record the shows
echo "Running the pvr"
get_iplayer ".*zane.*lowe.*" --get --type=radio --output $showDirectory --thumbnail --fileprefix="<pid>" --metadata=generic --modes=flashhd,flashvhigh,flashhigh,flashstd,flashnormal,flashlow,flashaachigh,flashaacstd,flashaudio,flashaaclow,wma

# For each downloaded show
declare -a processedPids
shopt -s nullglob
for filename in "$showDirectory"/*
do
	# Convert to m4a if not mp3 or m4a already
	filenameExtension="${filename##*.}"
	filenameNoExtension="${filename%.*}"
	if [ "$filenameExtension" != 'mp3' ] &&
		[ "$filenameExtension" != 'm4a' ] &&
		[ "$filenameExtension" != 'xml' ] &&
		[ "$filenameExtension" != 'jpg' ]
	then
		echo -n "Attempting to convert $filename to m4a....."
		ffmpeg -i $filename $filenameNoExtension.m4a
		rm $filename
		echo "Done."
	fi

	# Work out the pid
	pid=$(basename "$filenameNoExtension")

	# Only continue if we haven't processed this pid before
	if containsElement "$pid" "${processedPids[@]}"; then
		continue
	fi

	# Mark this pid as processed
	processedPids+=("$pid")
done

# Generate the podcast rss feed
sh $podcastFeedGeneratorScript

# Clean up
exec 1>&- 2>&-
wait $teepid
rm $nameOfFilePipe
