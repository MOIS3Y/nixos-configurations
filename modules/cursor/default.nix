# █▀▀ █░█ █▀█ █▀ █▀█ █▀█ ▀
# █▄▄ █▄█ █▀▄ ▄█ █▄█ █▀▄ ▄
# -- -- -- -- -- -- -- -- 

# The module sets the value of the cursor used for all desktop devices.
# It is needed so that the config.desktop.cursor option
# is available in both NixOS and HM.
# I do not set the values. It's formed as default
# using the guesCursorTheme function which takes colorSchemeName as input
# This is a little trick since I mainly use only the catppuccin_mocha scheme,
# I don't want to create cursor themes for all the other color schemes.
# pkgs.catppuccin-cursors are built on top of pkgs.volantes-cursors
# so I use this theme as a fallback for all other color schemes.

{ config, pkgs, lib, ... }: let
  guesCursorTheme = colorSchemeName: {
    name = if colorSchemeName == "catppuccin_mocha"
      then "catppuccin-mocha-blue-cursors"
      else if colorSchemeName == "catppuccin_frappe"
      then "catppuccin-frappe-blue-cursors"
      else if colorSchemeName == "catppuccin_macchiato"
      then "catppuccin-macchiato-blue-cursors"
      else if colorSchemeName == "catppuccin_latte"
      then "catppuccin-latte-blue-cursors"
      else "volantes_cursors";
    package = if colorSchemeName == "catppuccin_mocha"
      then pkgs.catppuccin-cursors.mochaBlue
      else if colorSchemeName == "catppuccin_frappe"
      then pkgs.catppuccin-cursors.frappeBlue
      else if colorSchemeName == "catppuccin_macchiato"
      then pkgs.catppuccin-cursors.macchiatoBlue
      else if colorSchemeName == "catppuccin_latte"
      then pkgs.catppuccin-cursors.latteBlue
      else pkgs.volantes-cursors;
  };
in {
  options.desktop.cursor = with lib; {
    name = mkOption {
      type = types.str;
      default = (guesCursorTheme config.colorSchemeName).name;
      description = "";
    };
    package = mkOption {
      type = types.package;
      default = (guesCursorTheme config.colorSchemeName).package;
      description = "";
    };
  };
  config = {};
}
