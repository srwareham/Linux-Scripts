Linux-Scripts
=============

Convenience scripts for everyday linux
* apt-get-updater
  * Script to run sudo apt-get update; sudo apt-get upgrade
  * Requires root
* ffmpeg-scritps
  * Convenience scripts for batch processing with ffmpeg
* file-renaming
  * Scripts for renaming batches of files with pre-existing naming schemes
  * Useful for moving media libraries to one convention
* time-syncer
  * Script to sync linux clock with NTP time server without password
  * Requires root

Dependencies:
* Mac OS X
  * brew install findutils
    - used for ffmpeg-scripts
    - Existing heuristic could likely be ported easily to BSD find
