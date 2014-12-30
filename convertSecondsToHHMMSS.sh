#!/bin/sh

if [[ $# -ne 1 ]]; then
	echo "You didn't give me any seconds to convert!"
	exit 1
fi

convertsecs() {
 ((h=${1}/3600))
  ((m=(${1}%3600)/60))
   ((s=${1}%60))
    printf "%02d:%02d:%02d\n" $h $m $s
}

echo $(convertsecs $1)

exit 0
