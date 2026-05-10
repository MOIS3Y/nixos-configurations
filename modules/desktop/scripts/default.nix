# █▀ █▀▀ █▀█ █ █▀█ ▀█▀ █▀ ▀
# ▄█ █▄▄ █▀▄ █ █▀▀ ░█░ ▄█ ▄
# -- -- -- -- -- -- -- -- -

{ lib, ... }: let
  inherit (lib)
    mkOption
    types;
  in {
  imports = [
    ./lf.nix
    ./hypridle.nix
    ./hyprland.nix
    ./swaync.nix
    ./waybar.nix
    ./wlogout.nix
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
