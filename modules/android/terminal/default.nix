# ▀█▀ █▀▀ █▀█ █▀▄▀█ █ █▄░█ ▄▀█ █░░ ▀
# ░█░ ██▄ █▀▄ █░▀░█ █ █░▀█ █▀█ █▄▄ ▄
# -- -- -- -- -- -- -- -- -- -- -- -

{ config, pkgs, ... }: let
  jetbrains = pkgs.nerd-fonts.jetbrains-mono;
  fontPath = "share/fonts/truetype/NerdFonts/JetBrainsMonoNerdFontMono-Regular.ttf";
  in {
  terminal = {
    colors = with config.colorScheme.palette; {
      background = "#${base00}";
      foreground = "#${base05}";
      cursor = "#${base06}";

      color0 = "#${base01}";
      color1 = "#${base08}";
      color2 = "#${base0B}";
      color3 = "#${base0A}";
      color4 = "#${base0D}";
      color5 = "#${base0E}";
      color6 = "#${base0C}";
      color7 = "#${base06}";

      color8 = "#${base04}";
      color9 = "#${base08}";
      color10 = "#${base0B}";
      color11 = "#${base0A}";
      color12 = "#${base0D}";
      color13 = "#${base0E}";
      color14 = "#${base0C}";
      color15 = "#${base06}";
    };
    font = "${jetbrains}/${fontPath}";
  };
}