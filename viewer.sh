#!/bin/bash

# $1 is ip of reciver. Start reciver program and then the streamer
gst-launch-1.0 -e -v udpsrc port=5001 ! application/x-rtp, encoding-name=JPEG, payload=26 ! rtpjpegdepay ! jpegdec ! autovideosink
