#!/usr/bin/env bash

export DISPLAY=:0
export XAUTHORITY=$HOME/.Xauthority

echo "Xft.dpi: 168" > ~/.Xresources
export GDK_SCALE=2
export GDK_DPI_SCALE=0.5

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
