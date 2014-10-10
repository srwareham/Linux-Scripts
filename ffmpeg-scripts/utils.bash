#!/bin/bash
# Create a directory if needed
createDirIfNeeded() {
    if [ ! -d "$1" ]; then
        mkdir "$1"
    fi
}
