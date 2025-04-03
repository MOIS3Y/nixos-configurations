# █▀ █▀▀ █▀█ █ █▀█ ▀█▀ █▀ ▀
# ▄█ █▄▄ █▀▄ █ █▀▀ ░█░ ▄█ ▄
# -- -- -- -- -- -- -- -- -

{ config, lib, ... }: let 
  inherit (lib)
    mkOption
    types;
  in {
  imports = [
    # common:
    ./lf.nix
    # wayland:
    ./hypridle.nix
    ./hyprland.nix
    ./waybar.nix
    ./wlogout.nix
    # xorg:
    ./dunst.nix
    ./xidlehook.nix
    ./xss-lock.nix
  ];
  options.desktop.scripts = mkOption {
    type = with types;
      let
        valueType = nullOr (oneOf [
          str
          path
          attrs
          (attrsOf valueType)
        ]) // {
          description = "Attrs with preconfigured scripts";
        };
      in valueType;
    description = "Preconfigured scripts";
  };
  config = {};
}
