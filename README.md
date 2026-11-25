# Welcome to your new EPITA's config
<img src="https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcSZvPi0HkU5Ufv1065pf84EysQoC5BmfUX8yCUY3YJgPtx6p3i-_XdbcJY&s=10" alt="NixOS Logo" width="200"/>

## Flake Content :
 - Mango Window Manager (dwm based)
 - Kitty
 - Starship
 - Neovim
 - Waybar
 - Fastfetch
 - SwayBG
 - WMenu
 - Jetbrains-Mono + Symbols Nerd Font

## Space Needed : 
__~200Mo__ Compressed / 1.8Go Decompressed - Estimated Time to download : 45 seconds (in Epita machine rooms)


## How to install :
When you are in the login screen (SDDM) at a EPITA computer, press Ctrl+Alt + Any F1/F2/F3 key that opens a new TTY. \
Then, login using your credentials as usual then, there is two methods : 
#### Auto install and launch :
You can clone the "start.sh" file from this git into your afs so it is persistent.
```bash
curl https://raw.githubusercontent.com/NydeTvs/epita-config/main/start.sh -sO
```
Make sure it is executable, if not :
```bash
chmod 777 start.sh
```
Then run ./start.sh, it will install the flake and directly launch a Mango session. \
Note that this method needs you to clone a file from this repository, the second one doesn't.
#### Manual install :
This procedure is the same as start.sh but by this method, nothing will stay in your afs. \
Run this command to install the flake :
```bash
home-manager switch -b backup --impure --flake github:NydeTvs/epita-config#epita
```
When the installation is done :
```bash
exec mango
```

## Features :
All the usual EPITA keybinds are kept :
- Win+D = Open drun (app launcher)
- Win+Return = Open terminal (Kitty)
- Win+Shift+Q = Close window

Other features were added to fit with wayland :

```
powermenu
set-wallpaper <path/to/image.png/jpg>
```

- powermenu : 
Win+Shift+E = Open powermenu (same behavior as usual but in wayland way)
- set-wallpaper : Param: path/to/a/image.png|jpg \
Allows you to dynamically change your wallpaper. Creates a copy of the image provided in afs so it is kept after reboot.

## Featured Repositories :
[MangoWM](https://github.com/mangowm/mango) \
[Kitty](https://github.com/kovidgoyal/kitty) \
[Starship](https://github.com/starship/starship) \
[Neovim](https://github.com/neovim/neovim) \
[Waybar](https://github.com/alexays/waybar) \
[Fastfetch](https://github.com/fastfetch-cli/fastfetch) \
[SwayBG](https://github.com/swaywm/swaybg) \
[WMenu](https://codeberg.org/adnano/wmenu)

