[theme_changer]: https://github.com/user-attachments/assets/9da37771-c02c-4b43-9895-63b8ea2739a9

# Dotfiles for custom Arch Linux + Hyprland config

## Core concepts
This configuration prioritizes simplicity and usability for developers, without sacrificing customizability and aesthetic.

## Configuration Overview
<a href="https://github.com/user-attachments/assets/051adf6d-499c-4ed0-bfde-dbf714c8b50e" target="_blank">
  <img src="https://github.com/user-attachments/assets/051adf6d-499c-4ed0-bfde-dbf714c8b50e" alt="SDDM Greeter" width="32.5%">
</a>
<a href="https://github.com/user-attachments/assets/cc831832-8fae-4997-b7af-83e77769ae40" target="_blank">
  <img src="https://github.com/user-attachments/assets/cc831832-8fae-4997-b7af-83e77769ae40" alt="Wlogout" width="32.5%">
</a>
<a href="https://github.com/user-attachments/assets/fa686d04-cfa2-475f-a757-a75cb4fa2f65" target="_blank">
  <img src="https://github.com/user-attachments/assets/fa686d04-cfa2-475f-a757-a75cb4fa2f65" alt="Shell and Notification Center" width="32.5%">
</a>
<a href="https://github.com/user-attachments/assets/fa7066c7-ec83-4e6c-a03e-7814cb2cfb14" target="_blank">
  <img src="https://github.com/user-attachments/assets/fa7066c7-ec83-4e6c-a03e-7814cb2cfb14" alt="App Launcher" width="32.5%">
</a>
<a href="https://github.com/user-attachments/assets/d926dd90-458e-408a-a85c-1f3c09347e4d" target="_blank">
  <img src="https://github.com/user-attachments/assets/d926dd90-458e-408a-a85c-1f3c09347e4d" alt="Clipboard" width="32.5%">
</a>
<a href="https://github.com/user-attachments/assets/c0f6a19a-c53e-4038-b0a0-353309e3c14b" target="_blank">
  <img src="https://github.com/user-attachments/assets/c0f6a19a-c53e-4038-b0a0-353309e3c14b" alt="General Showcase" width="32.5%">
</a>

### Shell and Terminal
- Main shell: bash
- Prompt: oh-my-posh
- Package manager: pacman and yay
- Emulator: Kitty
- Font: JetBrains Mono Nerd
- System info: btop, fastfetch

### User Experience and Aesthetic
- Status bar: waybar
- File manager: nautilus
- GTK / QT theme: adw-gtk3
- Icon set: Adwaita
- Login greeter: SDDM
- Lock: swaylock and wlogout
- Multimedia and audio: pamixer, pavucontrol, blueman, brightnessctl
- Network and safety: network-manager-applet, ufw, tlp
- Main browser: Brave

## Custom scripts
On each login some scripts are launched to enhanche the user experience. All of these can be found in "*~/.config/scripts*"
- **clean_java_workspaces.sh**: when working with java a folder gets created to cache compiled workspaces. This script deletes all those workspaces older than 3 months to avoid excessive memory usage.
- **clean_screenshots.sh**: all screenshots taken during current session are saved in "*~/Pictures/Screenshots*". On each login the content of this folder gets deleted to avoid keeping too many useless images.

## Theme changer
![alt_text][theme_changer]

There's a built-in theme changer to create custom themes starting from an image. To create a theme you just need to add a "*.png*" inside "*~/Pictures/wallpapers*" and launch the theme changer. Every aspect of the configuration will be adapted to mime the palette of the choosen image.

## Additional features
Some websites frequently used, such as ChatGpt, Google Gemini and Microsoft Teams, can be quickly launched with their specific shortcut. These concept can be further expanded by adding all frequently used apps. Some suggestions might be Whatsapp Web or Discord.
At the end of "*~/.config/hypr/hyprland.conf*" those shortcuts can be changed, or new ones can be added by following the same pattern.

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
