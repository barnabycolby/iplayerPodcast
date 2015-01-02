#!/bin/bash

# Read the config file
configFile="${HOME}/.iplayerPodcast/podcastFeed.cfg"
source $configFile

cat $pyxFeedFileEnd >> $pyxOutputFile
