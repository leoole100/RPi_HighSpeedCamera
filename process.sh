#!/bin/bash

echo""
echo "adding headers"
ls /dev/shm/*.raw | while read i; do cat /dev/shm/hd0.32k "$i" > "$i".all; done
echo""
echo "converting to tiff"
ls /dev/shm/*.all | while read i; do dcraw -f -o 1 -v  -6 -T -q 3 -W "$i"; done
echo""
echo "generating timestep file for ffmpeg"
python /home/pi/highspeedCamera/make_concat.py > /dev/shm/ffmpeg_concats.txt

echo""
echo "generating video"
ffmpeg -f concat -safe 0 -i /dev/shm/ffmpeg_concats.txt -vcodec libx265 -x265-params lossless -crf 30 -b:v 1M -pix_fmt yuv420p -vf "pad=ceil(iw/2)*2:ceil(ih/2)*2" -loglevel error -hide_banner -stats /dev/shm/video.mp4
