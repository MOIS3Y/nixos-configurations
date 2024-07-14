# █░█ ▀█▀ █ █░░ █▀ ▀
# █▄█ ░█░ █ █▄▄ ▄█ ▄
# -- -- -- -- -- --

{ config, pkgs, lib, ... }: with pkgs; with lib; {
  options.desktop.utils = mkOption {
    type = with types;
      let
        valueType = nullOr (oneOf [
          str
          path
          attrs
          (attrsOf valueType)
        ]) // {
          description = "Attrs with preconfigured utils";
        };
      in valueType;
    default = callPackage ./utils.nix {};
    description = "Preconfigured utils";
  };
  config = {};
}
