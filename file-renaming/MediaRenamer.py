'''
Written by Sean Wareham on Oct 29, 2014

Script to rename files according to pattern matching.  My primary use is to process files with FileBot and then
Feed them into this script to have custom formatting.

This script was primarily written to practice with RegEx.  As such, it is not very refined in its heuristic,
but it is fully functional.

'''
import re
import os

REGEX_ERROR = "ERROR: regex pattern not matched"
# "Sherlock - 11x17 - Bigfat.mp4"
TVDBExpression = "(.*) - ([0-9]{2})x([0-9]{2}) - (.*)\.(.*)"
# "Sherlock.S01E02.The.title.mp4" // need to remove periods from title / multi word series
# "Family Guy S11E17 Bigfat.mkv"
SSETFormatInfo = "(.*[^\s])\W*S([0-9]{2})E([0-9]{2})\W(.*)\.(.*)"

def getTVDBFormatInfo(inputString):
    match = re.search(TVDBExpression, inputString)
    if match is None:
        print REGEX_ERROR
        print "String was: _" + inputString +"_"
        return None
    else:
        series = match.group(1)
        seasonNumber = match.group(2)
        episodeNumber = match.group(3)
        episodeTitle = match.group(4)
        fileExtension = match.group(5)
        return (series, seasonNumber, episodeNumber, episodeTitle, fileExtension)

def getSSETFormatInfo(inputString):
    match = re.search(SSETFormatInfo, inputString)
    if match is None:
        print REGEX_ERROR
        print "String was: _" + inputString +"_"
        return None
    else:
        series = match.group(1)
        seasonNumber = match.group(2)
        episodeNumber = match.group(3)
        episodeTitle = match.group(4)
        fileExtension = match.group(5)
        return (series, seasonNumber, episodeNumber, episodeTitle, fileExtension)

def getFilename(episodeStats):
    if episodeStats is None:
        return None
    series = episodeStats[0]
    seasonNumber = episodeStats[1]
    episodeNumber = episodeStats[2]
    episodeTitle = episodeStats[3]
    fileExtension = episodeStats[4]
    return series + " - S" + seasonNumber + "E" + episodeNumber\
        + " - " + episodeTitle + "." + fileExtension
# Terrible implemtation that brute forces to find the appropriate technique.
def getNewName(filename):
    stats = getTVDBFormatInfo(filename)
    if stats is None:
        stats = getSSETFormatInfo(filename)
    if stats is None:
        return None
    return getFilename(stats)

def getOldPath(dirName, filename):
    return os.path.join(dirName, filename)

def getNewPath(dirName, filename):
    return os.path.join(dirName, getNewName(filename))

def renameDirContents(dirName):
    for filename in os.listdir(dirName):
        if not filename.startswith('.'):
            oldPath = getOldPath(dirName, filename)
            newPath = getNewPath(dirName, filename)
#            os.rename(oldPath,newPath)
            print "OLD: " + oldPath
            print "NEW: " + newPath

renameDirContents("/Volumes/Untitled/Media/Inbox/Family.Guy.S12E01-21.720p.WEB-DL.x264.AAC")
