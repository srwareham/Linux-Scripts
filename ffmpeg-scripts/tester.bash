#!/bin/bash

# Great one liner sourced from https://stackoverflow.com/questions/59895/can-a-bash-script-tell-what-directory-its-stored-in
# Gives us the directory of this script

vidsDir="/tmp/tester/vids"
scriptDir="$( cd "$( dirname "${BASH_SOURCE[0]}" )" && pwd )"

# Import utils script. NOTE: these files can't be moved or renamed
. "$scriptDir/utils.bash"


rm -rf "$vidsDir"
mkdir -p "$vidsDir"
touch "$vidsDir/one.mp4"
touch "$vidsDir/two.avi"
touch "$vidsDir/three.wmv"
touch "$vidsDir/four.mkv"



./ffmpegDir.bash "$vidsDir"
