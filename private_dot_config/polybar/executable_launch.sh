#!/usr/bin/env bash

# terminate already running bar instance
killall -q polybar

# launch bar
polybar i3bar --config="$HOME/.config/polybar/config.ini" \
    2>&1 | tee -a /tmp/polybar_i3bar.log &

echo "Bars launched..."
