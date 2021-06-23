#!/usr/bin/env bash

xrandr --output DP-0 --primary
xrandr --output DP-2 --rotate left --left-of DP-0
xrandr --output HDMI-0 --right-of DP-0
