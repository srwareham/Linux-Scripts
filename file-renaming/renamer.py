#!/usr/bin/python
# Written by Sean Wareham on October 13, 2014
# TODO: create undo function. Have function write log to known path and have undo apply a negative patch
# TODO: add support for defining a template for input naming scheme / output naming scheme
import sys
import os

args = sys.argv
dirName = args[1]
# List of commands (written in .sh) to be writtent to a file to be used as a negation of this script
reverseCommands=[]

def getFileExtension(filename):
    return ".mp4"
#TODO: Remove file system dependancy

def getSeriesName():
    return os.path.dirname(dirName).split("/")[-1]

def getSeasonNumber(filename):
    split = filename.split(".")
    return (split[0])

def getEpisodeNumber(filename):
    split = filename.split(".")
    split2 = split[1].split(" - ")
    return (split2[0])

def getEpisodeTitle(filename):
    split = filename.split(" - ")
    split2 = split[2].split(".")
    return split2[0]
# Takes the form: "SeriesName - S01E02 - EpisodeTitle.fileExtension"
def getNewName(filename):
    return getSeriesName() + " - S" + getSeasonNumber(filename)\
     + "E" + getEpisodeNumber(filename) + " - " +\
    getEpisodeTitle(filename) + getFileExtension(filename)

def getOldPath(filename):
    return os.path.join(dirName,filename)

def getNewPath(filename):
    return os.path.join(dirName,getNewName(filename))

#TODO: perhaps rewrite as a file that can be read by this program to run in python for compatability
def getReverseCommand(oldPath, newPath):
    return "mv \"" + newPath + "\" \"" + oldPath + "\""

for filename in os.listdir(dirName):
    if not filename.startswith('.'):
        oldPath = getOldPath(filename)
        newPath = getNewPath(filename)
#        os.rename(oldPath,newPath)
        print "OLD: " +oldPath
        print "NEW: " +newPath
        reverseCommands.append(getReverseCommand(oldPath,newPath))
#TODO: implement
#TODO: change implementation to be something like a csv that is then read by this program to undo
def saveReverseCommand():
    #create log at /tmp/logs/undoRename.sh
    #create with shebang then each line save.
    print "Unimplemented"
#TODO: implement
def undoLastRename():
    # run saved shell script
    print "Unimplemented"