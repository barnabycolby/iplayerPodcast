#!/bin/bash

# Read the config file
configFile=./podcastFeed.cfg
source $configFile

cat $pyxFeedFileEnd >> $pyxOutputFile
