#!/usr/bin/python3

import board
import neopixel
pixels = neopixel.NeoPixel(board.D18, 16)

pixels.fill((0, 0, 0))
# pixels[0] = (0,0,0)

pixels.show()
