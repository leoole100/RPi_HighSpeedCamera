#!/bin/bash
if [ "$#" -ne 5 ]; then
    echo "./record.sh [time_in_ms] [fps] [height] 640 [gain_no_unit]"
    echo "recomendet settings:"
    echo "fps:   1000 | 840 | 720 | 660 | 550 | 500 | 370 | 200"
    echo "height:80   | 96  | 120 | 120 | 145 | 180 | 360 | 480"
    echo "width: 640"
    exit
fi

./lights/processing.py

echo""
echo "detecting camera"
camera_i2c

echo""
echo "clearing memory"
rm /dev/shm/* # clear memory

echo""
echo "starting capture"
./lights/recording.py
raspiraw -md 7 -t $1 -ts /dev/shm/tstamps.csv -hd0 /dev/shm/hd0.32k -h $3 -w $4 --vinc 1F --fps $2 -sr 1 -g $5 -o /dev/shm/out.%06d.raw
./lights/processing.py

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
ffmpeg -f concat -safe 0 -i /dev/shm/ffmpeg_concats.txt -vcodec libx265 -x265-params lossless -crf 28 -b:v 1M -pix_fmt yuv420p -vf "pad=ceil(iw/2)*2:ceil(ih/2)*2" -loglevel error -hide_banner -stats /dev/shm/video.mp4

echo ""
echo ""
echo ""
echo ""
echo " ############################# analytics #############################"
echo ""
echo "timestamp distribution:"
echo "count  | time_in_us"
cut -f1 -d, /dev/shm/tstamps.csv  | sort -n | uniq -c
echo ""
df -h /dev/shm/
echo ""

./lights/off.py
