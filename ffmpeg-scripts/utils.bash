#!/bin/bash
# Written by Sean Wareham on October 10, 2014
#------------File System Utils---------------
# Create a directory if needed
createDirIfNeeded() {
    if [ ! -d "$1" ]; then
        mkdir "$1"
    fi
}

# First parameter = function to apply 2nd = directory to search
#3rd on are file extensions to be included in search
#NOTE: each argument starting at index 2 should be a file extension by itself with no "."
#NOTE: The function in the first parameter can exist either in this file (utils.bash) or in the calling file
processFilesInDirectory(){
    if [[ $# < 3 ]]; then
        echo "Too few arguments given."
        echo "Please provide: function to apply to each file path, directory to search, file extensio(s)"
        exit -1
    fi
    args=("$@")
    #extensionsRegex=".*\.\(avi\|wmv\|mkv\|mov\)"
    minusOne=$(($# - 1))
    extensionsRegex=".*\.\("
    for (( i = 2 ; i < "$minusOne" ; i++ )) do
         extensionsRegex+="${args[$i]}\\|"
    done
    extensionsRegex+="${args[$minusOne]}\\)"

    functionToApply="$1"
    directoryToSearch="$2"
    # Cannot combine these next two lines for some reason. Assuming underlying type conversion is at play.
    files="$( find "$directoryToSearch" -regex "$extensionsRegex" 2>/dev/null )"
    for file in $files 
    do
        "$functionToApply" "$file"
    done
}

#-----------Input Verification Utils---------
validateDirectory() {
    if [ ! -d "$1" ]; then
        echo \""$1"\" is not a valid directory. Terminating program.
        exit -1
    fi
}
