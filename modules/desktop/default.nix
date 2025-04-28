# █▀▄ █▀▀ █▀ █▄▀ ▀█▀ █▀█ █▀█ ▀
# █▄▀ ██▄ ▄█ █░█ ░█░ █▄█ █▀▀ ▄
# -- -- -- -- -- -- -- -- -- -

# The module sets values ​​for config.desktop.
# These values ​​are available across both NixOS and HM configurations.
# Options can be overridden or expanded later in the configuration 
# itself individually for each host.

{ lib, ... }: let
  inherit (lib)
    mkEnableOption
    mkOption
    literalExpression
    types;
  in {
  imports = [
    ./apps
    ./assets
    ./cursor
    ./devices
    ./games
    ./scripts
    ./utils
  ];
  options.desktop = {
    enable = mkEnableOption "Whether to enable desktop setup.";
    wayland = {
      enable = mkEnableOption "Whether to enable wayland setup.";
      compositors = mkOption {
        type = types.listOf (types.enum [
          "hyprland"
          "wayfire" 
        ]);
        default = [ "hyprland" ];
        description = "List of preconfigured wayland compositors";
        example = literalExpression ''
          compositors = [ "hyprland" "wayfire" ];
        '';
      };
    };
    xorg = {
      enable = mkEnableOption "Whether to enable X11 setup.";
      windowManagers = mkOption {
        type = types.listOf (types.enum [
          "awesome"
          "qtile"
        ]);
        default = [ "awesome" ];
        description = "List of preconfigured x11 window managers";
        example = literalExpression ''
          windowManagers = [ "awesome" "qtile" ];
        '';
      };
    };
  };
  config = {};
}