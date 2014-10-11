#!/bin/bash

#------------File System Utils---------------
# Create a directory if needed
createDirIfNeeded() {
    if [ ! -d "$1" ]; then
        mkdir "$1"
    fi
}

#-----------Input Verification Utils---------
validateDirectory() {
    if [ ! -d "$1" ]; then
        echo \""$1"\" is not a valid directory. Terminating program.
        exit -1;
    fi
}
