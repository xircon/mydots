#!/bin/bash
#NEEDED_WINDOW_CLASS="Navigator.firefox"
NEEDED_WINDOW_CLASS="Vivaldi.stable"
#LAUNCH_PROGRAM="/usr/bin/firefox --window-size 1600,900"
LAUNCH_PROGRAM="/usr/bin/vivaldi-stable"

#if [[ $(date +%u) -eq 7 ]] ; then
    #profile-cleaner f
#fi
        
######################################################################################################
NEEDED_WINDOW_WINDOW_ID_HEX=`wmctrl -x -l | grep "${NEEDED_WINDOW_CLASS}" | awk '{print $1}' | head -n 1`
NEEDED_WINDOW_WINDOW_ID_DEC=$((${NEEDED_WINDOW_WINDOW_ID_HEX}))
if [ -z "${NEEDED_WINDOW_WINDOW_ID_HEX}" ]; then
    wmctrl -s 2
    ${LAUNCH_PROGRAM}&
    #sleep 10
    #wmctrl -r firefox -b add,maximized_vert,maximized_horz
    #xinput disable 20
    #wmctrl -s 2
    # l-r & u-d
    # 360,470
    #xdotool mousemove 84 91
    #xdotool mousemove 48 83
    #sleep 2
    #if [[ "$XDG_SESSION_DESKTOP" == "GNOME" ]]; then
    #	xdotool mousemove 48 83
    #fi
    #xdotool click 3
    #xdotool key Up
    #xdotool key Return
    #xinput enable 20
else
    echo "Found window ID:${NEEDED_WINDOW_WINDOW_ID_DEC}(0x${NEEDED_WINDOW_WINDOW_ID_HEX})"
    ACIVE_WINDOW_DEC=`xdotool getactivewindow`
    if [ "${ACIVE_WINDOW_DEC}" == "${NEEDED_WINDOW_WINDOW_ID_DEC}" ]; then
        xdotool windowminimize ${NEEDED_WINDOW_WINDOW_ID_DEC}
    else
        xdotool windowactivate ${NEEDED_WINDOW_WINDOW_ID_DEC}
    fi
fi

