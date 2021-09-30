#!/bin/bash

# $1 is ip of reciver. Start reciver program and then the streamer
gst-launch-1.0 -v v4l2src ! "image/jpeg,width=1920,height=1080,framerate=30/1" ! rtpjpegpay ! udpsink host=$1 port=5001
