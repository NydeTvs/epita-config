{
  # Tokyo Night (Night) palette
  colors = {
    background    = "#1a1b26";
    backgroundAlt = "#24283b";
    foreground    = "#c0caf5";
    cursor        = "#7aa2f7";
    selection     = "#33467c";

    black   = "#15161e";
    red     = "#f7768e";
    green   = "#9ece6a";
    yellow  = "#e0af68";
    blue    = "#7aa2f7";
    magenta = "#bb9af7";
    cyan    = "#7dcfff";
    white   = "#a9b1d6";

    brightBlack   = "#414868";
    brightRed     = "#ff899d";
    brightGreen   = "#9fe044";
    brightYellow  = "#faba4a";
    brightBlue    = "#8db0ff";
    brightMagenta = "#c7a9ff";
    brightCyan    = "#a4daff";
    brightWhite   = "#c0caf5";

    # Additional Tokyo Night accents
    orange   = "#ff9e64";
    teal     = "#1abc9c";
    comment  = "#565f89";
    darkBlue = "#292e42";
  };

  apps = {
    fastfetch = {
      borders = "90";
      system = "blue";
      host = "magenta";
      wm = "cyan";
    };
    mango = {
      focuscolor = "0x7aa2f7ff";
    };
    waybar = {
      height = 35;
      margin = 8;
      fontSize = 12;
    };
    kitty = {
      opacity = 0.88;
      padding = 10;
      fontSize = 11;
    };
  };

  fonts = {
    main = {
      name = "JetBrains Mono";
      size = 11;
      pkg = "jetbrains-mono";
    };
    symbols = {
      name = "Symbols Nerd Font";
      pkg = "nerd-fonts.symbols-only";
    };
  };
}
