#!/usr/bin/python
# Written by Sean Wareham on October 13, 2014

import sys
import os

args = sys.argv
dirName = args[1]
seriesName = "Futurama"

def getFileExtension(filename):
    return ".mp4"

def getSeasonNumber(filename):
    split = filename.split(".")
    return (split[0])

def getEpisodeNumber(filename):
    split = filename.split(".")
    split2 = split[1].split(" - ")
    return (split2[0])

def getEpisodeName(filename):
    split = filename.split(" - ")
    split2 = split[1].split(".")
    return split2[0]

def renameFile(filename):
    newName= seriesName + " S" +getSeasonNumber(filename) + "E" + getEpisodeNumber(filename) + " - " + getEpisodeName(filename) + getFileExtension(filename)
    oldPath = os.path.join(dirName,filename)
    newPath = os.path.join(dirName,newName)
    os.rename(oldPath,newPath)

for file in os.listdir(dirName):
    if not file.startswith('.'):
        renameFile(file)
