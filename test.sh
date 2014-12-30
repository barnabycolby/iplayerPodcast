#!/bin/bash

source ./podcastFeed.cfg

infoFile=/home/barnaby/Documents/Home/get_iplayer/podcastScript/TestShows/13390.info
getAttribute="sh $infoExtractScript $infoFile"

dateNoFormat=$($getAttribute firstbcastdate)
echo "The dateNoFormat is: $dateNoFormat"

pubDate="$(sh $dateConvertScript $($getAttribute firstbcastdate))"

echo "The pubDate is: $pubDate"
