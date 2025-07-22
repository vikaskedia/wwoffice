#!/bin/bash

MEETING_ID="88427818415"

modprobe v4l2loopback devices=1 video_nr=10 card_label="ZoomCam" exclusive_caps=1
ffmpeg -stream_loop -1 -re -i /home/headless/dir-for-container-from-host/zoom-background.mp4 -vcodec rawvideo -pix_fmt yuv420p -f v4l2 /dev/video10 &

while true; do


    echo "Step 1: Launch Zoom if not running"
    if ! pgrep -x "zoom" > /dev/null; then
	echo "Zoom not running — starting..."
	zoom &
	sleep 10
    fi

    echo "Step 2: Focus the Zoom window that has the 4 main icons 1. New Meeting 2. Join 3. Schedule 4. Share screen"
    wmctrl -a "Zoom Workplace - Licensed account"
    sleep 3

    echo "Step 3: Move the window to 0,0 and min possible size"
    wmctrl -r "Zoom Workplace - Licensed account" -e 0,0,0,300,400
    sleep 3

    echo "Step 4: Check if window Meeting already exits and if it does then go to sleep for 30 seconds and try again"
    while wmctrl -l | grep "Meeting$"; do
	echo "Window 'Meeting' already exists. Sleeping for 30 seconds..."
	sleep 30
    done

    echo "Window 'Meeting' not found. Proceeding..."

    echo "Step 5: Going to click on join meeting"
    xdotool mousemove 262 216 
    sleep 2
    xdotool click 1

    echo "Step 6: Put the popup where I have to enter the meeting ID  at the default location to make the code less brittle."
    sleep 3
    WIN_ID=$(wmctrl -l | grep "Zoom Workplace$" | awk '{print $1}')
    if [ -n "$WIN_ID" ]; then
	wmctrl -i -r "$WIN_ID" -e 0,0,0,600,800
    fi

    echo "Step 7: Check mark dont connect to audio"
    xdotool mousemove 48 312
    sleep 2
    xdotool click 1

    echo "Step 8: Check mark turn off my video"
    xdotool mousemove 48 353
    sleep 2
    xdotool click 1

    echo "Step 9: Clicking on meeting ID text area"
    xdotool mousemove 63 203 
    sleep 2
    xdotool click 1

    echo "Step 10: Entering the meeting ID in the text area"
    xdotool type "$MEETING_ID"
    sleep 1
    xdotool key Return

    echo "Step 11: Wait for Zoom to join (you may need to adjust based on speed)"
    sleep 10

    echo "Step 12: Putting the window at the default location to make the code less brittle. Since after joiniung the zoom window gets maximized."
    wmctrl -r "Meeting" -b remove,maximized_vert,maximized_horz
    sleep 3
    wmctrl -r "Meeting" -e 0,0,0,1100,400
    sleep 3

    echo "Step 13: Click Breakout Rooms button"
    xdotool mousemove 822 390 click 1
    sleep 3

    echo "Step 14: Move the window to 0,0 and 600x400"
    wmctrl -r "Breakout rooms - Not Started" -e 0,0,0,600,400
    sleep 3

    echo "Step 15: Click open all rooms"
    xdotool mousemove 550 450 click 1
    sleep 1

    echo "Closing the Breakout rooms popup"
    wmctrl -c "Breakout rooms - In Progress"

    echo "Step 16: Meeting has been started. Going back to check if zoom is running and then if meeting is running after 60 seconds"
    sleep 60
done
