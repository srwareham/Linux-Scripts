#!/bin/bash
# Written by Sean Wareham on October 10, 2014
#------------File System Utils---------------
# Create a directory if needed
createDirIfNeeded() {
    if [ ! -d "$1" ]; then
        mkdir -p "$1"
    fi
}

# First parameter = function to apply 2nd = directory to search
#3rd on are file extensions to be included in search
#NOTE: each argument starting at index 2 should be a file extension by itself with no "."
#NOTE: The function in the first parameter can exist either in this file (utils.bash) or in the calling file
#NOTE: functionToApply needs to be provided the full file path of every file with the designated file extensions
#BUG: If you pass "/tmp" to find it will not work. "/tmp/" will work. May later add logic to prevent this.
processFilesInDirectory(){
    if [[ $(uname -s) = "Darwin" ]]; then
        local findUtil="gfind"
    else
        local findUtil="find"
    fi
    if [[ $# < 3 ]]; then
        echo "Too few arguments given."
        echo "Please provide: function to apply to each file path, directory to search, file extensio(s)"
        exit -1
    fi
    args=("$@")
    #extensionsRegex=".*\.\(avi\|wmv\|mkv\|mov\|mp4\|m4v\)"
    local minusOne=$(($# - 1))
    local extensionsRegex=".*\.\("
    for (( i = 2 ; i < "$minusOne" ; i++ )) do
         extensionsRegex+="${args[$i]}\\|"
    done
    extensionsRegex+="${args[$minusOne]}\\)"
    local functionToApply="$1"
    local searchDir="$2"
    # Cannot combine these next two lines for some reason. Assuming underlying type conversion is at play.
    "$findUtil" "$directoryToSearch" -regex "$extensionsRegex" 2>/dev/null | while read ln
    do
        "$functionToApply" "$ln"
    done
}

# function the takes full path and returns just the filename (no extension)
function getJustFilename {
	local fullfile="$1"
	local filename=$(basename "$fullfile")
	local extension="${filename##*.}"
	filename="${filename%.*}"
	echo "$filename"
}

#-----------Input Verification Utils---------
validateDirectory() {
    if [ ! -d "$1" ]; then
        echo "ERROR: \"$1\"" is not a valid directory. Terminating program.
        exit -1
    fi
}