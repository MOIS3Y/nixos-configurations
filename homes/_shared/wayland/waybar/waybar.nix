# █░█░█ ▄▀█ █▄█ █▄▄ ▄▀█ █▀█ ▀
# ▀▄▀▄▀ █▀█ ░█░ █▄█ █▀█ █▀▄ ▄
# -- -- -- -- -- -- -- -- -- 

{ config, pkgs, lib, ... }:
  let
    bars = import ./bars.nix { inherit config; inherit pkgs; inherit lib; };
    styles = import ./styles.nix { inherit config; inherit pkgs; };
  in {
  options = {
    programs.waybar.excludeWidgets = lib.mkOption {
      default = [];
      type = with lib.types; listOf (enum [
        "battery"
      ]);
      description = "Exclude widgets from current bar";
    };
  };
  config = {
    programs.waybar = {
      enable = true;
      systemd.enable = true;
      settings = {
        primaryBar = bars.primary;
      };
      style = styles.primary;
    };
  };
}
