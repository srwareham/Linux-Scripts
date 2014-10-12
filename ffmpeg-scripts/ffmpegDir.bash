#!/bin/bash

# Written by Sean Wareham on October 9, 2014
# This script aims to make converting  directories of files with ffmpeg easy on any system with bash installed
# This script recursively recreates the previous file hierarchy--only containing files of the desired output format
# NOTE: This script is not yet functioning
# IDEAS: Perhaps add a confirm dialog for passing a directory. If pass "~" could take unexpectedly long
# use helper file to get directoryToSearch
# use helper file to get outputDirectory
# create list of file extensions, pass this to helper file/function to then
# generate regex expression
# Great one liner sourced from https://stackoverflow.com/questions/59895/can-a-bash-script-tell-what-directory-its-stored-in
# Gives us the directory of this script
scriptDir="$( cd "$( dirname "${BASH_SOURCE[0]}" )" && pwd )"

# Import utils script. NOTE: this file can't be moved or renamed
. "$scriptDir"/utils.bash
# Import parsing script.
. "$scriptDir"/parsing.bash

#--------------------Constants------------------
# File formats we wish to convert
extensionsRegex=".*\.\(avi\|wmv\|mkv\|mov\)"
# Output file video codec
vcodec="libx264"
# Output file audio codec
acodec="libfdk_aac"
# Output file extension
outputExtension="mp4"

# Set search directory to be first arg.  If none given, set as current working directory
#TODO: do there need to be quotes around the ampersand?
directoryToSearch=$(getInputDirectoryPath "$@")

#----------------Setting up Output------------
outputDirectory="$2"
# If no output directory provided, create a new folder in the parent directory
# With the directoryToSearch's name + "[$outputExtension]
# This directory will be created if it does not already exist
# NOTE: we remove duplicate / for the edge cases of when the parent dir is /
# Otherwise we would have //tmp/ for example.
# Need to do this twice for it to work when we want /[mp4] for example. Really shouldn't want that, though.
if [ -z "$2" ]; then
    parentDir=$(dirname "$directoryToSearch")
    base=$(basename "$directoryToSearch")
# a forward slash is hardcoded, but we don't mind seeing as this is bash :)
    unparsed="$parentDir/$base[$outputExtension]"
    stage2=$(echo "$unparsed" | sed 's,//,/,g')
    outputDirectory=$(echo "$stage2" | sed 's,//,/,g')
fi

#---------------Input Verification---------------------
# Alert user that the provided directory is not a directory
# Immediately terminate and return failure code
if [ ! -d "$directoryToSearch" ]; then
    echo "$directoryToSearch" is not a directory
    exit -1;
fi


#------------------File finding Logic--------
#Note: This searches all subfolders and we repress all error messages
convertDesiredFiles(){
    for file in "$( find "$directoryToSearch" -regex ".*\.\(mp4\|avi\|wmv\|jpeg\)" 2>/dev/null )"
    do
        echo "$file"
    done
}

# For files that were already the proper file format, copy them to the output location
# Perhaps add option to convert mp4s as well. In case codec was different or lousy
copyPreviouslyAcceptableFiles(){
    echo hi
}

printMe() {
    echo "You wanted to print me: $1 and it worked!"
}
processFilesInDirectory printMe /tmp mp4 avi mkv
