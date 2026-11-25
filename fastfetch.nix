{ ... }:

let
  theme = import ./theme.nix;
in
{
    programs.fastfetch = {
    enable = true;
    settings = {
      logo = {
        type = "builtin";
        source = "nixos";
        color = {
          "1" = theme.colors.blue;
          "2" = theme.colors.magenta;
          "3" = theme.colors.blue;
          "4" = theme.colors.magenta;
          "5" = theme.colors.blue;
          "6" = theme.colors.magenta;
        };
        padding = {
          top = 0;
          left = 1;
          right = 2;
        };
      };
      display = {
        disableLinewrap = true;
        separator = ": ";
        color = {
          keys = theme.colors.cyan;
          title = theme.colors.magenta;
          separator = theme.colors.blue;
          output = theme.colors.foreground;
        };
      };
      modules = [
        {
          type = "title";
          color = {
            user = theme.colors.blue;
            at = theme.colors.comment;
            host = theme.colors.magenta;
          };
        }
        "separator"
        "os"
        "host"
        "kernel"
        "uptime"
        "display"
        "wm"
        "shell"
        "terminal"
        "terminalfont"
        "cpu"
        "gpu"
        "memory"
        "disk"
        "localip"
      ];
    };
  };
}
