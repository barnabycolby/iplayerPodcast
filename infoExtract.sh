#!/bin/bash

# Check that we've been given an argument
if [[ $# -ne 2 ]]; then
	echo "Parameters incorrect!"
	exit 1
fi

configFile='./podcastFeed.cfg'
source $configFile

# Assign the arguments to variables with more descriptive names
inputFile=$1
attributeToExtract=$2

# Generate an xpath expression to select the value with
xpathExpression="/_:program_meta_data/_:$attributeToExtract"

# Use xml starlet to get the attribute value by applying the xpath expression
# We pipe stderr to null to avoid it being printed to the screen
attributeValue="$($xmlstarlet sel --template --value-of $xpathExpression $inputFile 2> /dev/null)"

# Store the exit status of the call to xmlstarlet so that we can pass it on
xmlstarletExitStatus="$?"

if [ $xmlstarletExitStatus == '0' ]; then
	echo $attributeValue
fi

exit $xmlstarletExitStatus
