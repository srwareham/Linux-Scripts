#!/bin/bash

# Written by Sean Wareham on October 9, 2014
# This script aims to make converting  directories of files with ffmpeg easy on any system with bash installed
# IDEAS: Perhaps add a confirm dialog for passing a directory. If pass "~" could take unexpectedly long


# Great one liner sourced from https://stackoverflow.com/questions/59895/can-a-bash-script-tell-what-directory-its-stored-in
# Gives us the directory of this script
scriptDir="$( cd "$( dirname "${BASH_SOURCE[0]}" )" && pwd )"

# Import utils script. NOTE: these files can't be moved or renamed
. "$scriptDir/utils.bash"
# Import parsing script.
. "$scriptDir/parsing.bash"

#--------------------Constants------------------
# execute.sh path
executePath="/tmp/execution/execute.sh"
createDirIfNeeded "/tmp/execution"
# File formats we wish to convert
# TODO: add overloading defaults with parameters from command line
# Output file video codec
vcodec="libx264"
# Output file audio codec
acodec="libfdk_aac"
# Output file extension
outputExtension="mp4"
# Flag for whether or not to re-encode mp4s if the desired output is mp4. Useful
# In case you want a new codec for files that are already have the proper container.
reEncodeInputs=1
# Flag for debug mode. Commands will only be echoed.
DEBUG=0

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
    unparsed="$parentDir/$dirToSearchName-$outputExtension"
    # NOTE: we remove duplicate /'s for the edge cases of when the parent dir is /
    # Need to do this twice for it to work when we want /[mp4] for example. 
    outputDirectory=$(getWithoutDoubleSlashes "$unparsed")
fi
createDirIfNeeded "$outputDirectory"

#------------------File Manipulation Logic--------
executePath
# For files that were already the proper file format, copy them to the output location
# Perhaps add option to convert mp4s as well. In case codec was different or lousy
copyPreviouslyAcceptableFiles(){
    echo hi
}

# Parameters are input path and full output path. Codecs are global variables.
# Note: output path includes the file name and extension
ffmpegConvert(){
    if [[ "$DEBUG" = "1" ]]; then
        echo ffmpeg -i "\"$1\"" -acodec "$acodec" -vcodec "$vcodec" "\"$2\""
    else
        echo ffmpeg -i "\"$1\"" -acodec "$acodec" -vcodec "$vcodec" "\"$2\"" >> "$executePath"
    fi
}

# Parameters are input path and full output path.
moveFile(){
    if [[ "$DEBUG" = "1" ]]; then
        echo mv "\"$1\"" "\"$2\""
    else
        echo mv "\"$1\"" "\"$2\"" >> "$executePath"
    fi
}

# Returns the new path of a given input file.
getOutputPath(){
    local filename=$(getJustFilename "$1")
    local parentLength=${#directoryToSearch}
    local childLength=${#1}
    let childLength-=parentLength
    let startIndex=parentLength
    local childPath=${1:startIndex:childLength}
    local outputPath="$outputDirectory/$childPath"
    newChildDir=$(dirname "$outputPath")
    unparsed="$newChildDir/$filename.$outputExtension"
    parsed=$(getWithoutDoubleSlashes "$unparsed")
    echo "$parsed"
}

# Function to either move or convert a file based on its file extension
ffmpegConvertOrMove(){
    local inputPath="$1"
    local outputPath=$(getOutputPath "$inputPath")
    #create outputpath if needed
    createDirIfNeeded "$(dirname "$outputPath")"
    # If we want to re-encode, re-encode, else move the file
    local extLen=${#outputExtension}
    local index=${#inputPath}
    let index-=$extLen
    local inputExtension=${inputPath:$index:$extLen}
    if [[ "$reEncodeInputs" = "1" ]];then
        ffmpegConvert "$inputPath" "$outputPath"
    else
        if [[ "$inputExtension" = "$outputExtension" ]]; then
            moveFile "$inputPath" "$outputPath"
        else
            ffmpegConvert "$inputPath" "$outputPath"
        fi
    fi 
}

rm "$executePath"

# Search and process typical media types
# TODO: switch to defaults types that are overridden 
processFilesInDirectory ffmpegConvertOrMove "$directoryToSearch" mp4 m4v wmv avi mkv webm flv
sh "$executePath"
