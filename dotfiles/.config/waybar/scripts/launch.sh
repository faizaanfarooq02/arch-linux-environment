#!/bin/bash

while pkill -x waybar >/dev/null; do sleep 1; done

waybar &
