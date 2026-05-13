# ▀█▀ █▀▀ █▀█ █▀▄▀█ █ █▄░█ ▄▀█ █░░ ▀
# ░█░ ██▄ █▀▄ █░▀░█ █ █░▀█ █▀█ █▄▄ ▄
# -- -- -- -- -- -- -- -- -- -- -- -
# Configures terminal colors and fonts for Nix-on-Droid.

{
  config,
  pkgs,
  ...
}:
let
  jetbrains = pkgs.nerd-fonts.jetbrains-mono;
  fontPath = "share/fonts/truetype/NerdFonts/JetBrainsMonoNerdFontMono-Regular.ttf";
  inherit (config.matugen) mode;
  palette = config.matugen.theme.custom.palette.${mode};
in
{
  terminal = {
    colors = {
      background = palette.bg_base;
      foreground = palette.fg_text;
      cursor = palette.fg_text;

      color0 = palette.black;
      color1 = palette.red;
      color2 = palette.green;
      color3 = palette.yellow;
      color4 = palette.blue;
      color5 = palette.magenta;
      color6 = palette.cyan;
      color7 = palette.white;

      color8 = palette.bright_black;
      color9 = palette.bright_red;
      color10 = palette.bright_green;
      color11 = palette.bright_yellow;
      color12 = palette.bright_blue;
      color13 = palette.bright_magenta;
      color14 = palette.bright_cyan;
      color15 = palette.bright_white;
    };
    font = "${jetbrains}/${fontPath}";
  };
}
