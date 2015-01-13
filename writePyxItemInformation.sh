#!/bin/bash

if [[ $# -ne 1 ]]; then
	echo "Invalid number of arguments given."
	exit 1
fi

configFile="${HOME}/.iplayerPodcast/podcastFeed.cfg"
source $configFile

# We assume that the filename is in the format 'pid.xxx' so that we can get the related information
filename=$1
filenameNoExtension="${filename%.*}"
pid=$(basename "$filenameNoExtension")
infoFile="$filenameNoExtension.xml"
getAttribute="sh $infoExtractScript $infoFile"

# Redirect standard output to the pyx output file
exec 1>> $pyxOutputFile

echo "(item"

title="$($getAttribute episodeshort)"
if [ $? == 0 ]; then
	echo "(title"
	echo "-$title"
	echo ")title"
fi

description="$($getAttribute desc)"
descriptionResult=$?
if [ $descriptionResult == 0 ]; then
	echo "(description"
	echo "-$description"
	echo ")description"
fi

firstbcastdate="$($getAttribute firstbcastdate)"
if [ $? == 0 ]; then
	pubDate="$(sh $dateConvertScript $firstbcastdate)"
	if [ $? == 0 ]; then
		echo "C Must conform to RFC 2822 "
		echo "(pubDate"
		echo "-$pubDate"
		echo ")pubDate"
	fi
fi

url="$mediaFileDirectoryURL/$pid.m4a"
echo "C The url of the media file (so that we know it's unique) "
echo "(guid"
echo "-$url"
echo ")guid"

durationAttributeValue="$($getAttribute duration)"
if [ $? == 0 ]; then
	duration="$(sh $convertSecondsToHHMMSS $durationAttributeValue)"
	if [ $? == 0 ]; then
		echo "C Itunes item tags "
		echo "C HH:MM:SS, H:MM:SS, MM:SS or M:SS "
		echo "(itunes:duration"
		echo "-$duration"
		echo ")itunes:duration"
	fi
fi

if [ $descriptionResult == 0 ]; then
	echo "(itunes:subtitle"
	echo "-$description"
	echo ")itunes:subtitle"
fi

fileLength="$(stat -c%s $filename)"
#fileMimeType="$(file --mime-type --brief $filename)"
fileExtension="${filename##*.}"
if [ $fileExtension == "mp3" ]; then
	fileMimeType='audio/mpeg'
elif [ $fileExtension == 'm4a' ]; then
	fileMimeType='audio/x-m4a'
fi
echo "(enclosure"
echo "Alength $fileLength"
echo "Atype $fileMimeType"
echo "Aurl $url"
echo ")enclosure"

# Add the episodes image to the item if it exists
if [ -f $filenameNoExtension.jpg ]; then
	episodeImageURL="$mediaFileDirectoryURL/$pid.jpg"
	echo "(itunes:image"
	echo "Ahref $episodeImageURL"
	echo ")itunes:image"
fi
echo ")item"
