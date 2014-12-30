#!/bin/bash

# Exit immediately if anything fails
set -e

# Read the config file
configFile=./podcastFeed.cfg
echo -n "Reading config....."
source $configFile
echo "Done."

# Write the start of the pyx rss file
echo -n "Writing channel information....."

sh $writeChannelInformationScript
echo "Done."

# Write the podcast items
shopt -s nullglob
for show in "$showDirectory"/*.{m4a,mp3,wma}
do
	filename=$show
#	filename="${show%.*}"
	echo -n "Adding item node for $filename file....."
	sh $writeItemInformationScript $filename
	echo "Done."
done

echo -n "Closing tags....."
sh $writeClosingTagsScript
echo "Done."

echo -n "Converting pyx file to xml....."
$xmlstarlet depyx $pyxOutputFile > $rssOutputFile
echo "Done."

echo -n "Formatting rss output file....."
cat $rssOutputFile | xmllint --format - > $rssOutputFile.formatted
rm $rssOutputFile
mv $rssOutputFile.formatted $rssOutputFile
echo "Done."

echo -n "Cleaning up....."
rm $pyxOutputFile
echo "Done."
