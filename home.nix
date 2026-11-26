{ inputs, pkgs, lib, ... }:

let
  username = builtins.getEnv "USER";
  theme = import ./theme.nix;
  hex = lib.removePrefix "#";
  swaylock-i3lock = pkgs.runCommand "swaylock-effects-i3lock" {
        nativeBuildInputs = [ pkgs.perl ];
    } ''
    mkdir -p $out
    cp -r ${pkgs.swaylock-effects}/* $out/
    chmod -R u+w $out/bin
    perl -pi -e 's/swaylock\x00/i3lock\x00\x00\x00/g' $out/bin/swaylock
  '';
in
{
  imports = [
    ./mango.nix
    ./waybar.nix
    ./neovim.nix
    ./fastfetch.nix
    ./kitty.nix
    ./starship.nix
  ];

  home.activation.backupExistingBashrc = lib.hm.dag.entryBefore [ "checkLinkTargets" ] ''
    if [ -e "$HOME/.bashrc" ] || [ -L "$HOME/.bashrc" ]; then
      case "$(readlink "$HOME/.bashrc" 2>/dev/null)" in
        /nix/store/*) ;;
        *) mv -f "$HOME/.bashrc" "$HOME/.bashrc.backup" ;;
      esac
    fi
  '';

  programs.bash = {
    enable = true;

    shellAliases = {
      ls = "ls --color=auto";
      grep = "grep --color=auto -n";
    };

    sessionVariables = {
      LANG = "en_US.utf8";
      NNTPSERVER = "news.epita.fr";
      EDITOR = "vim";
    };

    initExtra = ''
      if [ -d "$HOME/afs/bin" ]; then
        export PATH="$HOME/afs/bin:$PATH"
      fi

      if [ -d "$HOME/.local/bin" ]; then
        export PATH="$HOME/.local/bin:$PATH"
      fi

    '';
  };


  home.username = username;
  home.homeDirectory = "/home/${username}";
  home.stateVersion = "24.11";

  fonts.fontconfig.enable = true;
  home.packages = with pkgs; [
        jetbrains-mono
        nerd-fonts.symbols-only
        wmenu

        (writeShellScriptBin "i3lock" ''
          WALLPAPER_ARGS=""
          if [ -f "$HOME/afs/wallpaper.png" ]; then
            WALLPAPER_ARGS="--image $HOME/afs/wallpaper.png --scaling fill --effect-blur 7x5 --effect-vignette 0.5:0.5"
          elif [ -f "$HOME/afs/wallpaper.jpg" ]; then
            WALLPAPER_ARGS="--image $HOME/afs/wallpaper.jpg --scaling fill --effect-blur 7x5 --effect-vignette 0.5:0.5"
          fi

          OFF_TIME=$(date -d "+1 hour" "+%H:%M")

          (
            sleep 3600
            systemctl poweroff
          ) &
          TIMER_PID=$!

          ${swaylock-i3lock}/bin/swaylock \
            $WALLPAPER_ARGS \
            --clock \
            --indicator \
            --indicator-idle-visible \
            --indicator-radius 175 \
            --indicator-thickness 10 \
            --font "${theme.fonts.main.name}" \
            --timestr "%H:%M:%S" \
            --datestr "${username} • Off $OFF_TIME" \
            --color ${hex theme.colors.background} \
            --inside-color ${hex theme.colors.background}C0 \
            --inside-clear-color ${hex theme.colors.backgroundAlt}C0 \
            --inside-ver-color ${hex theme.colors.backgroundAlt}C0 \
            --inside-wrong-color ${hex theme.colors.backgroundAlt}C0 \
            --ring-color ${hex theme.colors.blue} \
            --ring-clear-color ${hex theme.colors.yellow} \
            --ring-ver-color ${hex theme.colors.cyan} \
            --ring-wrong-color ${hex theme.colors.red} \
            --key-hl-color ${hex theme.colors.green} \
            --bs-hl-color ${hex theme.colors.red} \
            --text-color ${hex theme.colors.foreground} \
            --text-clear-color ${hex theme.colors.yellow} \
            --text-ver-color ${hex theme.colors.cyan} \
            --text-wrong-color ${hex theme.colors.red} \
            --line-color 00000000 \
            --separator-color 00000000

          pkill -P "$TIMER_PID" 2>/dev/null || true
          kill "$TIMER_PID" 2>/dev/null || true
        '')
        (writeShellScriptBin "powermenu" ''
        choice=$(printf "Logout\nReboot\nShutdown" | wmenu -p "Session:")
        case "$choice" in
            Logout) loginctl terminate-session "$XDG_SESSION_ID" ;;
            Reboot) systemctl reboot ;;
            Shutdown) systemctl poweroff ;;
        esac
        '')
        (writeShellScriptBin "set-wallpaper" ''
          if [ -z "$1" ] || [ ! -f "$1" ]; then
            echo "Usage: set-wallpaper <path/to/image.png|jpg>"
            exit 1
          fi
          ext="''${1##*.}"
          ext="''${ext,,}"
          if [ "$ext" != "png" ] && [ "$ext" != "jpg" ]; then
            echo "Unsupported format (please use .png or .jpg)"
            exit 1
          fi
          rm -f "$HOME/afs/wallpaper.png" "$HOME/afs/wallpaper.jpg"
          cp "$1" "$HOME/afs/wallpaper.$ext"
          pkill swaybg || true
          ${pkgs.swaybg}/bin/swaybg -i "$HOME/afs/wallpaper.$ext" -m fill >/dev/null 2>&1 &
        '')
        (writeShellScriptBin "kitty-fetch" ''
          exec ${pkgs.kitty}/bin/kitty -e bash -c 'fastfetch; exec bash'
        '')
  ];
}
