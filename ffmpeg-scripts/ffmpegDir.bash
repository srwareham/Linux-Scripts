#!/bin/bash

# Written by Sean Wareham on October 9, 2014

# This script aims to make converting  directories of files with ffmpeg easy on any system with bash installed
# This script recursively recreates the previous file hierarchy--only containing files of the desired output format

# NOTE: This script is not yet functioning

#IDEAS: Perhaps add a confirm dialog for passing a directory. If pass "~" could take unexpectedly long

#--------------------Constants------------------
# File formats we wish to convert
extensionsRegex=".*\.\(avi\|wmv\|mkv\|mov\)"
# Output file video codec
vcodec="libx264"
# Output file audio codec
acodec="libfdk_aac"
# Output file extension
outputExtension="mp4"

# Set the directory to search to be the first arg
directoryToSearch="$1"
# If no arg given, set search directory to current working directory
# NOTE: we do not use an $ in front of directoryToSearch because it is not
# defined if we reach this segment of code
if [ -z "$1" ]; then
directoryToSearch="$PWD"
fi


#-----------------Utility Functions-----------
getFileName(){
    local filename="$(basename "$1")"
    echo "$filename"
}

createDirIfNeeded() {
    if [ ! -d "$1" ]; then
        mkdir "$1"
    fi
}



#----------------Setting up Output------------
outputDirectory="$2"
# If no output directory provided, create a new folder in the parent directory
# With the directoryToSearch's name + "[$outputExtension]
# This directory will be created if it does not already exist
# NOTE: we remove duplicate / for the edge cases of when the parent dir is /
# Otherwise we would have //tmp/ for example
if [ -z "$2" ]; then
    parentDir=$(dirname "$directoryToSearch")
    base=$(basename "$directoryToSearch")
# a forward slash is hardcoded, but we don't mind seeing as this is bash :)
    unparsed="$parentDir/$base[$outputExtension]"
    outputDirectory=$(echo "$unparsed" | sed 's,//,/,g')
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
convertDesiredFiles
echo $outputDirectory
