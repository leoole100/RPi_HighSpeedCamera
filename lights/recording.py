#!/usr/bin/python3

import board
import neopixel
import time

pixels = neopixel.NeoPixel(board.D18, 16, brightness=1.0)

pixels.fill((255, 255, 255))
# pixels[0] = (0,0,0)

pixels.show()
