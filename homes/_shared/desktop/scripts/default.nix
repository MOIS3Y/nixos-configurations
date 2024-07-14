# █▀ █▀▀ █▀█ █ █▀█ ▀█▀ █▀ ▀
# ▄█ █▄▄ █▀▄ █ █▀▀ ░█░ ▄█ ▄
# -- -- -- -- -- -- -- -- -

{ config, pkgs, lib, ... }: with pkgs; with lib; {
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
    default = callPackage ./scripts.nix { inherit config; };
    description = "Preconfigured scripts";
  };
  config = {};
}
