{ ... }:

let
  theme = import ./theme.nix;
in
{
  programs.kitty = {
    enable = true;

    font = {
      name = theme.fonts.main.name;
      size = theme.apps.kitty.fontSize;
    };

    shellIntegration.enableBashIntegration = true;

    settings = {
      shell = "bash";

      # Appearance & Transparency
      background_opacity = theme.apps.kitty.opacity;
      window_padding_width = theme.apps.kitty.padding;
      hide_window_decorations = true;
      confirm_os_window_close = 0;

      # Cursor
      cursor_shape = "beam";
      cursor_beam_thickness = 1.8;
      cursor_blink_interval = 0.5;
      cursor_stop_blinking_after = 15;
      cursor_trail = 3;
      cursor_trail_decay = "0.1 0.4";

      # Scrollback & Performance
      scrollback_lines = 10000;
      enable_audio_bell = false;
      repaint_delay = 10;
      input_delay = 3;
      sync_to_monitor = true;

      # URLs
      url_color = theme.colors.cyan;
      url_style = "curly";

      # Tab bar (Powerline / Slanted)
      tab_bar_edge = "top";
      tab_bar_style = "powerline";
      tab_powerline_style = "slanted";
      tab_bar_min_tabs = 2;
      tab_title_template = " {index}: {title} ";
      active_tab_font_style = "bold";
      inactive_tab_font_style = "normal";

      # Tokyo Night colors
      foreground = theme.colors.foreground;
      background = theme.colors.background;
      selection_foreground = theme.colors.foreground;
      selection_background = theme.colors.selection;

      cursor = theme.colors.cursor;
      cursor_text_color = theme.colors.background;

      # Tab colors
      active_tab_foreground = theme.colors.background;
      active_tab_background = theme.colors.blue;
      inactive_tab_foreground = theme.colors.white;
      inactive_tab_background = theme.colors.backgroundAlt;
      tab_bar_background = theme.colors.black;

      # Window border colors
      active_border_color = theme.colors.blue;
      inactive_border_color = theme.colors.brightBlack;

      # ANSI 16 colors
      color0 = theme.colors.black;
      color1 = theme.colors.red;
      color2 = theme.colors.green;
      color3 = theme.colors.yellow;
      color4 = theme.colors.blue;
      color5 = theme.colors.magenta;
      color6 = theme.colors.cyan;
      color7 = theme.colors.white;

      color8 = theme.colors.brightBlack;
      color9 = theme.colors.brightRed;
      color10 = theme.colors.brightGreen;
      color11 = theme.colors.brightYellow;
      color12 = theme.colors.brightBlue;
      color13 = theme.colors.brightMagenta;
      color14 = theme.colors.brightCyan;
      color15 = theme.colors.brightWhite;

      # Extended Tokyo Night accents
      color16 = theme.colors.orange;
      color17 = theme.colors.red;
    };

    keybindings = {
      "ctrl+shift+t" = "new_tab_with_cwd";
      "ctrl+shift+enter" = "new_window_with_cwd";
      "ctrl+shift+left" = "previous_tab";
      "ctrl+shift+right" = "next_tab";
    };
  };
}
