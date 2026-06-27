-- Converted from hyprland.conf
-- Place this file at ~/.config/hypr/hyprland.lua
-- Split files are loaded with Lua require(), relative to ~/.config/hypr/.

require("device-settings")
require("dynamic-border")

-- Starting scripts
hl.on("hyprland.start", function()
	hl.exec_cmd("~/.config/hypr/xdg-portals.sh") -- Make sure the correct portals are running
	hl.exec_cmd("dbus-update-activation-environment --systemd WAYLAND_DISPLAY XDG_CURRENT_DESKTOP") -- Wayland magic
	hl.exec_cmd("systemctl --user import-environment WAYLAND_DISPLAY XDG_CURRENT_DESKTOP") -- More Wayland magic
	hl.exec_cmd("/usr/lib/polkit-gnome/polkit-gnome-authentication-agent-1") -- graphical sudo elevation
	hl.exec_cmd("blueman-applet") -- Systray app for BT
	hl.exec_cmd("nm-applet --indicator") -- Systray app for Network/Wifi
	hl.exec_cmd("waybar") -- Status bar
	hl.exec_cmd("swaync") -- Notification center
	hl.exec_cmd(
		"awww-daemon && awww img ~/.config/wallpaper/current_wallpaper.png --transition-type fade --transition-duration 0.5"
	) -- Wallpaper

	-- Utility and customization scripts
	hl.exec_cmd("~/.config/scripts/clean_screenshots.sh")
	hl.exec_cmd("~/.config/scripts/clean_java_workspaces.sh")
	hl.exec_cmd("~/.config/scripts/update_configs.sh")

	-- Clipboard
	hl.exec_cmd("cliphist wipe")
	hl.exec_cmd("wl-paste --type text -w cliphist store")
end)

hl.config({
	ecosystem = {
		no_update_news = true,
		no_donation_nag = true,
	},

	input = {
		kb_layout = "it",
		follow_mouse = 1,
		repeat_rate = 50,
		repeat_delay = 300,
		accel_profile = "flat",
	},

	general = {
		gaps_in = 5,
		gaps_out = 10,
		border_size = 2,
		col = {
			inactive_border = "rgba(595959aa)",
		},
		layout = "dwindle",
	},

	misc = {
		disable_hyprland_logo = true,
	},

	decoration = {
		rounding = 5,
		blur = {
			enabled = true,
			size = 7,
			passes = 4,
			new_optimizations = true,
		},
		shadow = {
			enabled = true,
			range = 4,
			render_power = 3,
			color = "rgba(1a1a1aee)",
		},
	},

	animations = {
		enabled = true,
	},

	dwindle = {
		preserve_split = true,
	},

	master = {
		new_status = "master",
	},
})

hl.curve("myBezier", { type = "bezier", points = { { 0.10, 0.9 }, { 0.1, 1.05 } } })
hl.animation({ leaf = "windows", enabled = true, speed = 5, bezier = "myBezier", style = "slide" })
hl.animation({ leaf = "border", enabled = true, speed = 10, bezier = "default" })
hl.animation({ leaf = "fade", enabled = true, speed = 7, bezier = "default" })
hl.animation({ leaf = "workspaces", enabled = true, speed = 3, bezier = "default" })

-- Set utilities to floating
hl.window_rule({ name = "float-pavucontrol", match = { class = "pavucontrol" }, float = true })
hl.window_rule({ name = "float-blueman-manager", match = { class = "blueman-manager" }, float = true })
hl.window_rule({ name = "float-nm-connection-editor", match = { class = "nm-connection-editor" }, float = true })

-- Disable rofi animation for resizing
hl.layer_rule({ name = "rofi-no-anim", match = { namespace = "rofi" }, no_anim = true })

_G.mainMod = "SUPER"
local mainMod = _G.mainMod

-- Apps and system
hl.bind(mainMod .. " + RETURN", hl.dsp.exec_cmd("kitty"))
hl.bind(mainMod .. " + SHIFT + RETURN", hl.dsp.exec_cmd("kitty -o allow_remote_control=yes"))
hl.bind(mainMod .. " + Q", hl.dsp.window.close())
hl.bind(mainMod .. " + SHIFT + Q", hl.dsp.window.kill())
hl.bind(mainMod .. " + SHIFT + L", hl.dsp.exec_cmd("swaylock -K"))
hl.bind(mainMod .. " + M", hl.dsp.exec_cmd("wlogout --protocol layer-shell"))
hl.bind(mainMod .. " + E", hl.dsp.exec_cmd("nautilus"))
hl.bind(mainMod .. " + F", hl.dsp.window.float({ action = "toggle" }))
hl.bind(mainMod .. " + SHIFT + F", hl.dsp.window.fullscreen({ action = "toggle", mode = "fullscreen" }))
hl.bind(mainMod .. " + B", hl.dsp.exec_cmd("brave-origin --password-store=basic"))
hl.bind("PRINT", hl.dsp.exec_cmd("hyprshot -m output -o ~/Pictures/Screenshots"))
hl.bind(mainMod .. " + PRINT", hl.dsp.exec_cmd("hyprshot -m window -o ~/Pictures/Screenshots"))
hl.bind(mainMod .. " + SHIFT + PRINT", hl.dsp.exec_cmd("hyprshot -m region -o ~/Pictures/Screenshots"))
hl.bind(mainMod .. " + SHIFT + S", hl.dsp.exec_cmd("hyprshot -m region -o ~/Pictures/Screenshots"))
hl.bind(mainMod .. " + N", hl.dsp.exec_cmd("swaync-client -t"))
hl.bind(mainMod .. " + SPACE", hl.dsp.exec_cmd("rofi -theme ~/.config/rofi/app_launcher.rasi -show drun"))
hl.bind(mainMod .. " + SHIFT + T", hl.dsp.exec_cmd("bash -c $HOME/.config/scripts/theme_changer/theme_chooser.sh"))
hl.bind(
	mainMod .. " + V",
	hl.dsp.exec_cmd(
		"cliphist list | rofi -dmenu -theme ~/.config/rofi/clipboard.rasi | cliphist decode | wl-copy && wtype -M ctrl v -m ctrl"
	)
)

-- Move focus with mainMod + vim keys
hl.bind(mainMod .. " + H", hl.dsp.focus({ direction = "l" }))
hl.bind(mainMod .. " + L", hl.dsp.focus({ direction = "r" }))
hl.bind(mainMod .. " + K", hl.dsp.focus({ direction = "u" }))
hl.bind(mainMod .. " + J", hl.dsp.focus({ direction = "d" }))

-- Workspaces 1-10; key 0 maps to workspace 10
for i = 1, 10 do
	local key = i % 10
	hl.bind(mainMod .. " + " .. key, hl.dsp.focus({ workspace = i }))
	hl.bind(mainMod .. " + SHIFT + " .. key, hl.dsp.window.move({ workspace = i }))
end

-- Scroll through existing workspaces
hl.bind(mainMod .. " + mouse_down", hl.dsp.focus({ workspace = "e+1" }))
hl.bind(mainMod .. " + mouse_up", hl.dsp.focus({ workspace = "e-1" }))

-- Move/resize windows with mouse
hl.bind(mainMod .. " + mouse:272", hl.dsp.window.drag(), { mouse = true })
hl.bind(mainMod .. " + mouse:273", hl.dsp.window.resize(), { mouse = true })

-- Open custom websites as apps
hl.bind(mainMod .. " + C", hl.dsp.exec_cmd("brave-origin --password-store=basic --app=https://chat.openai.com/"))
hl.bind(mainMod .. " + G", hl.dsp.exec_cmd("brave-origin --password-store=basic --app=https://gemini.google.com/"))
hl.bind(mainMod .. " + T", hl.dsp.exec_cmd("brave-origin --password-store=basic --app=https://teams.microsoft.com/v2/"))
hl.bind(mainMod .. " + W", hl.dsp.exec_cmd("brave-origin --password-store=basic --app=https://web.whatsapp.com/"))

require("custom-keybinds")
