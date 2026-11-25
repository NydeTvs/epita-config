{ pkgs, ... }:

let
  theme = import ./theme.nix;
in
{
  programs.neovim = {
    enable = true;
    defaultEditor = true;
    viAlias = true;
    vimAlias = true;
    withPython3 = false;
    withRuby = false;
    withNodeJs = false;
    withPerl = false;

    plugins = with pkgs.vimPlugins; [
      base16-nvim
      lualine-nvim
      nvim-web-devicons
      indent-blankline-nvim
      (nvim-treesitter.withPlugins (p: [
        p.c
        p.cpp
        p.python
        p.bash
        p.nix
        p.make
        p.markdown
      ]))
    ];

    initLua = ''
      vim.g.mapleader = " "

      vim.opt.number = true
      vim.opt.cursorline = true
      vim.opt.relativenumber = true
      vim.opt.shiftwidth = 4
      vim.opt.tabstop = 4
      vim.opt.expandtab = true
      vim.opt.termguicolors = true

      require("base16-colorscheme").setup({
        base00 = "${theme.colors.background}",
        base01 = "${theme.colors.backgroundAlt}",
        base02 = "${theme.colors.selection}",
        base03 = "${theme.colors.brightBlack}",
        base04 = "${theme.colors.white}",
        base05 = "${theme.colors.foreground}",
        base06 = "${theme.colors.brightWhite}",
        base07 = "${theme.colors.brightWhite}",
        base08 = "${theme.colors.red}",
        base09 = "${theme.colors.orange}",
        base0A = "${theme.colors.yellow}",
        base0B = "${theme.colors.green}",
        base0C = "${theme.colors.cyan}",
        base0D = "${theme.colors.blue}",
        base0E = "${theme.colors.magenta}",
        base0F = "${theme.colors.red}",
      })

      require("lualine").setup({
        options = { theme = "base16" },
      })

      require("ibl").setup()

      vim.api.nvim_create_autocmd("FileType", {
        callback = function()
          if pcall(vim.treesitter.start) then
            vim.bo.indentexpr = "v:lua.require'nvim-treesitter'.indentexpr()"
          end
        end,
      })
    '';
  };
}
