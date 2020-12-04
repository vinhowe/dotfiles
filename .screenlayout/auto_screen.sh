#!/usr/bin/env bash

# useful resource: https://frdmtoplay.com/i3-udev-xrandr-hotplugging-output-switching/

DIR="$( cd "$( dirname "${BASH_SOURCE[0]}" )" >/dev/null 2>&1 && pwd )"

HDMI_STATUS=$(</sys/class/drm/card0/card0-HDMI-A-1/status )

set -e

echo [$(date -u)] "attempting to automatically set screen output settings"

export DISPLAY=:0
export XAUTHORITY=$HOME/.Xauthority

echo "Xft.dpi: 192" > ~/.Xresources
export GDK_SCALE=2
export GDK_DPI_SCALE=0.5

if [ "$HDMI_STATUS" == "connected" ]
then
    echo [$(date)] "setting mode to docked"
    echo [$(date -u)] "attempting to set HDMI1 settings"

    xrandr --output HDMI1 --auto --left-of eDP1
    xrandr --output HDMI1 --primary --mode 3840x2160 --scale 1x1 --dpi 192 --rotate normal --pos 0x0 --verbose
    xrandr --output eDP1 --right-of HDMI1 --auto --scale 2x2 --verbose


    if [ "$1" == "w" ]
    then
        i3-msg '[class=".*"]' move workspace to output HDMI1
        i3-msg workspace 1
        i3-msg [workspace=0] move workspace to output eDP1
    fi

    notify-send "HDMI active" "Switching to docked mode"
else
    echo [$(date -u)] "setting mode to mobile"

    xrandr --auto && xrandr --output HDMI1 --off
    xrandr --output eDP1 --primary --dpi 192 --mode 1366x768 --scale 2x2

    if [ "$1" == "w" ]
    then
        i3-msg '[class=".*"]' move workspace to output eDP1
        i3-msg workspace 0
    fi

    notify-send "HDMI inactive" "Switching to mobile mode"
fi

i3-msg reload
xrdb -merge ~/.Xresources

# Give things time to settle before setting background, which can be pretty fragile
sleep 1

# Download large background image if it doesn't exist so I don't have to check it into version control
if [ ! -f $DIR/sombrero.jpg ]
then
    wget "https://cdn.spacetelescope.org/archives/images/large/opo0328a.jpg" -O "$DIR/sombrero.jpg"
fi

feh --no-fehbg --bg-fill "$DIR/sombrero.jpg"
