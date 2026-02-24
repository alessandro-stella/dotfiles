#!/usr/bin/env bash

event="$1"
level="$2"
title="$3"
message="$4"

notify() {
    local icon="$1"
    local urgency="$2"  # normal, critical
    local title="$3"
    local message="$4"
    notify-send -a batsignal -i "$icon" -u "$urgency" "$title" "$message"
}

case "$event" in
    charging)
        notify "battery-good-charging-symbolic" "normal" "Battery Charging" "$message"
        ;;
    full)
        notify "battery-full-charged-symbolic" "normal" "Battery Full" "$message"
        ;;
    discharging)
        if [ "$level" -le 10 ]; then
            notify "battery-caution-symbolic" "critical" "Battery Critically Low!" "Please connect charger immediately! Level: $level%"
        elif [ "$level" -le 30 ]; then
            notify "battery-low-symbolic" "normal" "Low Battery" "Level: $level%"
        fi
        ;;
esac
