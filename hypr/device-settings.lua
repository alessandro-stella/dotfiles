-- Per-device and monitor configuration converted from device-settings.conf

-- Main monitor
hl.monitor({
  output = "eDP-1",
  mode = "1920x1080@60",
  position = "0x0",
  scale = 1.2,
})

-- Mirror main on HDMI
-- NOTE: mirror is kept as a raw extra field; verify on your Hyprland build.
hl.monitor({
  output = "HDMI-A-1",
  mode = "preferred",
  position = "auto",
  scale = 1,
  mirror = "eDP-1",
})

-- Touchpad settings
hl.config({
  input = {
    touchpad = {
      natural_scroll = true,
      scroll_factor = 0.3,
      disable_while_typing = true,
    },
  },
})

hl.device({
  name = "synaptics-tm3625-010",
  sensitivity = 0.6,
})

hl.device({
  name = "tpps/2-elan-trackpoint",
  sensitivity = 0.3,
})
