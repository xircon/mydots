#!/bin/bash
######################################################################################################
NEEDED_WINDOW_CLASS="emacs.Emacs"
LAUNCH_PROGRAM="emacsclient -c ~/.t.org"
######################################################################################################
NEEDED_WINDOW_WINDOW_ID_HEX=`wmctrl -x -l | grep ${NEEDED_WINDOW_CLASS} | awk '{print $1}' | head -n 1`
NEEDED_WINDOW_WINDOW_ID_DEC=$((${NEEDED_WINDOW_WINDOW_ID_HEX}))

ems=$(pgrep -c emacs)
echo "emacs count $ems"
if [ $ems == "0" ]; then
    echo "Starting server......."
	systemctl restart --user emacs&
else
  pgrep -c emacs
fi	

if [ -z "${NEEDED_WINDOW_WINDOW_ID_HEX}" ]; then
    killall winctl
    winctl ~/scripts/winctl/emacs.lua &
    wmctrl -s 1
    sleep 2
    ${LAUNCH_PROGRAM}&
    notify-send "running"
    #winctl ~/scripts/winctl/emacs.lua &
else
    echo "Found window ID:${NEEDED_WINDOW_WINDOW_ID_DEC}(0x${NEEDED_WINDOW_WINDOW_ID_HEX})"
    ACIVE_WINDOW_DEC=`xdotool getactivewindow`
    if [ "${ACIVE_WINDOW_DEC}" == "${NEEDED_WINDOW_WINDOW_ID_DEC}" ]; then
        xdotool windowminimize ${NEEDED_WINDOW_WINDOW_ID_DEC}
    else
        xdotool windowactivate ${NEEDED_WINDOW_WINDOW_ID_DEC}
    fi
fi
