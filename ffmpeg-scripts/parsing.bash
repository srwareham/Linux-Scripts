#!/bin/bash
# Written by Sean Wareham on October 10, 2014
# Given the args of a script, return the desired input directory
# The first arg given is assumed to be the input directory
# If no args are given, the default value is the current working directory
getInputDirectoryPath() {
    local inputDir="$1"
    if [ -z "$1" ]; then
        local inputDir="$PWD"
    fi
    echo "$inputDir"
}
