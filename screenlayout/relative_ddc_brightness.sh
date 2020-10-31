#!/usr/bin/env bash

BRIGHTNESS=$(sudo ddcutil getvcp 10 | sed 's/ *//g' | grep -Eo 'currentvalue=[0-9]+' | grep -Eo '[0-9]+')

NEW_VALUE=$((BRIGHTNESS+$1))
NEW_VALUE=$((NEW_VALUE > 100 ? 100 : NEW_VALUE))
NEW_VALUE=$((NEW_VALUE < 0 ? 0 : NEW_VALUE))

sudo ddcutil setvcp 10 $NEW_VALUE
