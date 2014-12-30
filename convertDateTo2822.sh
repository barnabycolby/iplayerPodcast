#!/bin/bash

# Check that we've been given a date to convert
if [[ $# -ne 1 ]]; then
	echo "You didn't give me a date to convert!"
	exit 1;
fi

# Convert the date
date -d"$1" -R

exit $?
