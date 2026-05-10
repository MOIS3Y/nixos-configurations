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
    desktopManager = {
      gnome.enable = mkEnableOption ''
        Whether to enable GNOME desktop manager
      '';
    };
    displayManager = {
      enable = mkEnableOption ''
        Whether to enable systemd’s display-manager service.
      '';
      sddm.enable = mkEnableOption ''
        Whether to enable sddm as the display manager.
      '';
      gdm.enable = mkEnableOption ''
        Whether to enable GDM, the GNOME display manager.
      '';
      greetd.enable = mkEnableOption ''
        Whether to enable greetd, a minimal and flexible login manager daemon.
      '';
    };
    compositors = mkOption {
      type = types.listOf (types.enum [
        "hyprland"
        "wayfire"
        "niri"
      ]);
      default = [ ];
      description = "List of preconfigured compositors";
      example = literalExpression ''
        compositors = [ "hyprland" "niri" ];
      '';
    };
  };
  config = {};
}
