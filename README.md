[theme_changer]: https://github.com/user-attachments/assets/85ed96c1-540c-4394-8dcf-07f1aee4036f

# Dotfiles for custom Arch Linux + Hyprland config
This configuration prioritizes simplicity and usability for developers, without sacrificing customizability and aesthetic.

<br>

## Configuration Overview
<img src="https://github.com/user-attachments/assets/d17316e3-3372-438e-98d2-ffc7b73b1926" alt="SDDM Greeter" width="32.5%">
<img src="https://github.com/user-attachments/assets/cc831832-8fae-4997-b7af-83e77769ae40" alt="Wlogout" width="32.5%">
<img src="https://github.com/user-attachments/assets/240c1a7d-17a0-4734-8dd7-1dfa24a5472d" alt="Shell and Notification Center" width="32.5%">
<img src="https://github.com/user-attachments/assets/16a0e470-7a05-4234-8a17-3100ea7e8ec4" alt="App Launcher" width="32.5%">
<img src="https://github.com/user-attachments/assets/f00b5f7e-476b-46f3-b285-d21b6ef16564" alt="Clipboard" width="32.5%">
<img src="https://github.com/user-attachments/assets/c4266adf-ccd5-482e-910a-0589fde4c0f9" alt="General Showcase" width="32.5%">

### Shell and Terminal
- Main shell: bash
- Prompt: oh-my-posh
- Package manager: pacman and yay
- Emulator: Kitty (<kbd>SUPER</kbd> + <kbd>ENTER</kbd>)
- Font: JetBrains Mono Nerd
- System info: btop, fastfetch

### User Experience and Aesthetic
- Status bar: waybar
- File manager: nautilus (<kbd>SUPER</kbd> + <kbd>E</kbd>)
- GTK / QT theme: adw-gtk3
- Icon set: Adwaita
- Login greeter: SDDM with a slightly edited version of <a href="https://github.com/xCaptaiN09/pixie-sddm">pixie</a> theme
- Lock: swaylock (<kbd>SUPER</kbd> + <kbd>SHIFT</kbd> + <kbd>L</kbd>) and wlogout (<kbd>SUPER</kbd> + <kbd>M</kbd>)
- Notification management: swaync (<kbd>SUPER</kbd> + <kbd>N</kbd>)
- Multimedia and audio: pamixer, pavucontrol, blueman, brightnessctl
- Network and safety: network-manager-applet, ufw, tlp
- Main browser: Brave (<kbd>SUPER</kbd> + <kbd>B</kbd>)

<br>

## Keybinds
- Close window: <kbd>SUPER</kbd> + <kbd>Q</kbd>
- Graphical App Launcher: <kbd>SUPER</kbd> + <kbd>SPACE</kbd>
- Open Clipboard: <kbd>SUPER</kbd> + <kbd>V</kbd>
- Take a screenshot of a portion of the screen: <kbd>SUPER</kbd> + <kbd>SHIFT</kbd> + <kbd>S</kbd>
- Make a window fullscreen: <kbd>SUPER</kbd> + <kbd>SHIFT</kbd> + <kbd>F</kbd>


<br>

## Custom scripts
On each login some scripts are launched to enhanche the user experience. All of these can be found in "*~/.config/scripts*"
- **clean_java_workspaces.sh**: when working with java a folder gets created to cache compiled workspaces. This script deletes all those workspaces older than 3 months to avoid excessive memory usage.
- **clean_screenshots.sh**: all screenshots taken during current session are saved in "*~/Pictures/Screenshots*". On each login the content of this folder gets deleted to avoid keeping too many useless images.

<br>

## Theme changer
![alt_text][theme_changer]

There's a built-in theme changer to create custom themes starting from an image. To create a theme you just need to add a "*.png*" inside "*~/Pictures/wallpapers*" and launch the theme changer. Every aspect of the configuration will be adapted to mime the palette of the choosen image. The theme will then be saved inside "*~/.config/themes/\<IMG NAME\>*" to both avoid useless delays and to better customize the new theme.

<br>

## Additional features
Although some apps don't have a proper arch/wayland port they can be easily mimicked by opening a web app in a native app window. Some websites frequently used, such as Whatsapp Web, ChatGpt, Google Gemini and Microsoft Teams, can be quickly launched with their specific shortcut. This concept can be further expanded by adding all frequently used apps. Some suggestions might be Discord, Chess.com, YouTube and a lot more.
At the end of "*~/.config/hypr/hyprland.conf*" those shortcuts can be changed, or new ones can be added by following the same pattern in "*~/.config/hypr/custom-keybinds.conf*".

<br>

## Installation

One liner
```bash
curl -fsSL https://raw.githubusercontent.com/alessandro-stella/dotfiles/master/install.sh | \
sudo HYPRLAND_INSTANCE_SIGNATURE=$HYPRLAND_INSTANCE_SIGNATURE bash
```

Manual
```bash
git clone https://github.com/<username>/dotfiles.git ~/.dotfiles
cd ~/.dotfiles
./install.sh
```
