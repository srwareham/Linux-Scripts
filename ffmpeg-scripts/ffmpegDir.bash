#!/bin/bash

# Written by Sean Wareham on October 9, 2014
# This script aims to make converting  directories of files with ffmpeg easy on any system with bash installed
# NOTE: This script is not yet functioning and currently has linux dependencies.
# IDEAS: Perhaps add a confirm dialog for passing a directory. If pass "~" could take unexpectedly long


# Great one liner sourced from https://stackoverflow.com/questions/59895/can-a-bash-script-tell-what-directory-its-stored-in
# Gives us the directory of this script
scriptDir="$( cd "$( dirname "${BASH_SOURCE[0]}" )" && pwd )"

# Import utils script. NOTE: these files can't be moved or renamed
. "$scriptDir/utils.bash"
# Import parsing script.
. "$scriptDir/parsing.bash"

#--------------------Constants------------------
# File formats we wish to convert
# TODO: add overloading defaults with parameters from command line
# Output file video codec
vcodec="libx264"
# Output file audio codec
acodec="libfdk_aac"
# Output file extension
outputExtension="mp4"

# Set search directory to be first arg.  If none given, set as current working directory
directoryToSearch=$(getInputDirectoryPath "$@")
# If no input path is given, use the current working directory
if [ -z "$directoryToSearch" ]; then
    directoryToSearch="$PWD"
fi
# Confirm desired input path exists. Terminate otherwise.
validateDirectory "$directoryToSearch"

#----------------Setting up Output------------
# Define the output directory to be the parameter supplied.
# If none given, output directory is defined as the input directory plus [fileExtension]
# This directory will be created if it does not already exist

outputDirectory=$(getOutputDirectoryPathParameter "$@")
if [ -z "$outputDirectory" ]; then
    parentDir=$(dirname "$directoryToSearch")
    dirToSearchName=$(basename "$directoryToSearch")
    unparsed="$parentDir/$dirToSearchName[$outputExtension]"
    # NOTE: we remove duplicate / for the edge cases of when the parent dir is /
    # Really shouldn't run a find over entire file system though.
    stage2=$(echo "$unparsed" | sed 's,//,/,g')
    # Need to do this twice for it to work when we want /[mp4] for example. 
    outputDirectory=$(echo "$stage2" | sed 's,//,/,g')
fi

#------------------File Manipulation Logic--------

# For files that were already the proper file format, copy them to the output location
# Perhaps add option to convert mp4s as well. In case codec was different or lousy
copyPreviouslyAcceptableFiles(){
    echo hi
}

# Place holder to test processFilesInDirectory.
printMe() {
    echo "You wanted to print me: $1 and it worked!"
}

processFilesInDirectory printMe "$directoryToSearch" mp4 wmv avi mkv
echo "New output Dir: $outputDirectory"