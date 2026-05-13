# █▀▀ █▀█ █▄░█ █▀ █▀█ █░░ █▀▀ ▀
# █▄▄ █▄█ █░▀█ ▄█ █▄█ █▄▄ ██▄ ▄
# -- -- -- -- -- -- -- -- -- --
# Configures the TTY console font, keymap and colors.

{
  config,
  pkgs,
  lib,
  ...
}:
let
  inherit (config.matugen) mode;
  palette = config.matugen.theme.custom.palette.${mode};
  stripHash = color: lib.strings.removePrefix "#" color;
in
{
  console = {
    earlySetup = true;
    font = "ter-k16n"; # RU
    packages = [ pkgs.terminus_font ];
    keyMap = "us";
    colors = map stripHash [
      palette.black
      palette.red
      palette.green
      palette.yellow
      palette.blue
      palette.magenta
      palette.cyan
      palette.white

      palette.bright_black
      palette.bright_red
      palette.bright_green
      palette.bright_yellow
      palette.bright_blue
      palette.bright_magenta
      palette.bright_cyan
      palette.bright_white
    ];
  };
}
