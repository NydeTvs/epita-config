{ lib, ... }:

let
  theme = import ./theme.nix;
in
{
  programs.starship = {
    enable = true;
    enableBashIntegration = true;

    settings = {
      add_newline = true;
      scan_timeout = 500;

      format = lib.concatStrings [
        "[╭─](bold ${theme.colors.brightBlack})"
        "[  ](bold ${theme.colors.blue})"
        "$username"
        "$directory"
        "$git_branch"
        "$git_state"
        "$git_status"
        "$c"
        "$python"
        "$nix_shell"
        "$cmd_duration"
        "$fill"
        "$time"
        "\n"
        "[╰─](bold ${theme.colors.brightBlack})"
        "$character"
      ];

      fill = {
        symbol = " ";
      };

      username = {
        show_always = true;
        style_user = "bold ${theme.colors.magenta}";
        style_root = "bold ${theme.colors.red}";
        format = "[$user]($style) ";
      };

      directory = {
        style = "bold ${theme.colors.blue}";
        read_only = " 󰌾";
        read_only_style = theme.colors.red;
        truncation_length = 3;
        truncation_symbol = "…/";
        format = "[󰉋 $path]($style)[$read_only]($read_only_style) ";
      };

      git_branch = {
        symbol = " ";
        style = "bold ${theme.colors.magenta}";
        format = "on [$symbol$branch(:$remote_branch)]($style) ";
      };

      git_state = {
        style = "bold ${theme.colors.orange}";
        format = "([$state( $progress_current/$progress_total)]($style)) ";
      };

      git_status = {
        style = "bold ${theme.colors.yellow}";
        format = "([\\[$all_status$ahead_behind\\]]($style) )";
        conflicted = "=";
        ahead = "⇡\${count}";
        behind = "⇣\${count}";
        diverged = "⇕⇡\${ahead_count}⇣\${behind_count}";
        untracked = "?";
        stashed = "*";
        modified = "!";
        staged = "+";
        renamed = "»";
        deleted = "✘";
      };

      c = {
        symbol = " ";
        style = "bold ${theme.colors.cyan}";
        format = "via [$symbol($version(-$name) )]($style)";
      };

      python = {
        symbol = " ";
        style = "bold ${theme.colors.yellow}";
        format = "via [$symbol$pyenv_prefix($version )(\\($virtualenv\\) )]($style)";
      };

      nix_shell = {
        symbol = "󱄅 ";
        style = "bold ${theme.colors.blue}";
        format = "via [$symbol$state( \\($name\\))]($style) ";
      };

      cmd_duration = {
        min_time = 2000;
        style = "bold ${theme.colors.yellow}";
        format = "took [󱎫 $duration]($style) ";
      };

      time = {
        disabled = false;
        time_format = "%H:%M";
        style = theme.colors.comment;
        format = "[󰥔 $time]($style)";
      };

      character = {
        success_symbol = "[❯](bold ${theme.colors.cyan})";
        error_symbol = "[❯](bold ${theme.colors.red})";
        vimcmd_symbol = "[❮](bold ${theme.colors.green})";
      };
    };
  };
}
