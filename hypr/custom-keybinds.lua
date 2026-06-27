-- Custom keybinds converted from custom-keybinds.conf

local mainMod = _G.mainMod or "SUPER"

-- Use F keys
hl.bind("XF86AudioMute", hl.dsp.exec_cmd("pamixer -t")) -- F1
hl.bind("XF86AudioLowerVolume", hl.dsp.exec_cmd("pamixer -d 1")) -- F2
hl.bind("XF86AudioRaiseVolume", hl.dsp.exec_cmd("pamixer -i 1")) -- F3
hl.bind("XF86AudioMicMute", hl.dsp.exec_cmd("sh -c 'wpctl set-mute @DEFAULT_SOURCE@ toggle'")) -- F4
hl.bind("XF86MonBrightnessDown", hl.dsp.exec_cmd("brightnessctl set 1%-")) -- F5
hl.bind("XF86MonBrightnessUp", hl.dsp.exec_cmd("brightnessctl set +1%")) -- F6

-- Close all AI
hl.bind(mainMod .. " + SHIFT + C", hl.dsp.exec_cmd([[bash -lc 'hyprctl clients -j | jq -r ".[] | select((.class // \"\" | test(\"^brave-(chat[.]openai[.]com|gemini[.]google[.]com)\"; \"i\")) or (.initialClass // \"\" | test(\"^brave-(chat[.]openai[.]com|gemini[.]google[.]com)\"; \"i\"))) | .address" | xargs -r -I{} hyprctl dispatch closewindow address:{}']]))
