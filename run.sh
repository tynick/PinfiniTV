#!/bin/bash

# base directory where all videos are stored
# this could be a USB drive, SD card or even a NAS
# videos will be sorted alphabetically 
VIDEO_DIRECTORY=/mnt/media/

# list the file types you want played here. separated by pipes. not case sensitive
FILE_TYPES='mkv|mp4'


get_playlist() 
{ 
    # get recursive list of files in video directory
    playlist=$(find "${VIDEO_DIRECTORY}" -type f | sort -n)
    # filter out the file types we dont want
    playlist=$(echo "${playlist}" | grep -Ei "^.*\.($FILE_TYPES)$")
    echo "${playlist}"
}

# start looping through the videos
while :
do
    # get new playlist after old has played
    # this allows you do add new videos without stopping the service
    playlist=$(get_playlist)
    for video in $(echo "${playlist}") 
    do
        echo "${video}"
	# still playing with these settings but they seem to work for my TV
	# you may have to adjust for your setup
        omxplayer --display 5 -p -o hdmi --win "0 0 1920 1080" "${video}"
    done
done
