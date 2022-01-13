#!/bin/sh

/usr/bin/xinput list | /usr/bin/grep II
if [ $? -eq 0 ]; then
/usr/bin/xinput set-button-map "Lenovo TrackPoint Keyboard II Mouse" 1 0 3 4 5 6 7
fi
