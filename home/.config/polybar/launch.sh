#!/usr/bin/env bash

polybar-msg cmd quit
# killall -q polybar

echo "---" | tee -a /tmp/polybar_top.log /tmp/polybar_bot.log
polybar top 2>&1 | tee -a /tmp/polybar_top.log & disown
polybar bot 2>&1 | tee -a /tmp/polybar_bot.log & disown

echo "Bars launched..."
