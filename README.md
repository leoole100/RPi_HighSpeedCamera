# RPi HighSpeedCamera

This is a collection of Programms to use the Raspberry Camera as a 1000Hz High Speed Camera.

# Based on
* https://github.com/Hermann-SW/fork-raspiraw
* https://blog.robertelder.org/recording-660-fps-on-raspberry-pi-camera/
* https://github.com/6by9/dcraw

# Usage
For the installation follow https://blog.robertelder.org/recording-660-fps-on-raspberry-pi-camera/ guide.

1. Preview:
Start `viewer.sh` on the viewer PC. Then start `stream.sh [ip of the viewer.pc]` on the Raspberry Pi.
To end the Preview stop both programms.
The center oft the top the frame will be recorded.

2. Recording:
Start `record.sh 500 1000 70 640 240` to start the recording.

3. Processing:
Start `processing.sh` and a Video will be created under `\dev\shm\video.mp4`. The slowdown Factor is configured in `make_contact.py`.
