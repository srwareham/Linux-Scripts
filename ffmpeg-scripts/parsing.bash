#!/bin/bash
# Written by Sean Wareham on October 10, 2014
# TODO: Switch to a flags based implementation with default overloading.

# The first arg given is assumed to be the input directory
getInputDirectoryPath() {
    if [ ! -z "$1" ]; then
        echo "$1"
    fi
}

getOutputDirectoryPathParameter(){
    if [ ! -z "$2" ]; then
        echo "$2"
    fi
}