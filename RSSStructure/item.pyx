echo "(item"
echo "-\\n\\t\\t\\t"
echo "(title"
echo "-Monday night versus with Rodigan"
echo ")title"
echo "-\\n\\t\\t\\t"
echo "(link"
echo ")link"
echo "-\\n\\t\\t\\t"
echo "(description"
echo "-Zane talks to Rodigan, the sound clash champion."
echo ")description"
echo "-\\n\\t\\t\\t"
echo "C Must conform to RFC 2822 "
echo "-\\n\\t\\t\\t"
echo "(pubDate"
echo "-Sat, 20 Dec 2014 13:00:00 GMT"
echo ")pubDate"
echo "-\\n\\t\\t\\t"
echo "C The url of the media file (so that we know it's unique) "
echo "-\\n\\t\\t\\t"
echo "(guid"
echo "-http://www.barnabycolby.com/zanelowepodcast/Show123.m4a"
echo ")guid"
echo "-\\n\\n\\t\\t\\t"
echo "C Itunes item tags "
echo "-\\n\\t\\t\\t"
echo "C HH:MM:SS, H:MM:SS, MM:SS or M:SS "
echo "-\\n\\t\\t\\t"
echo "(itunes:duration"
echo "-2:00:00"
echo ")itunes:duration"
echo "-\\n\\t\\t\\t"
echo "(itunes:subtitle"
echo "-$(description)>"
echo ")itunes:subtitle"
echo "-\\n\\n\\t\\t\\t"
echo "(enclosure"
echo "Alength 1024000"
echo "Atype audio/x-m4a"
echo "Aurl http://www.barnabycolby.com/zanelowepodcast/Show123.m4a"
echo ")enclosure"
echo "-\\n\\t\\t"
echo ")item"