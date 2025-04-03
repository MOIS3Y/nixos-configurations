# █░█ ▀█▀ █ █░░ █▀ ▀
# █▄█ ░█░ █ █▄▄ ▄█ ▄
# -- -- -- -- -- --

{ config, pkgs, lib, ... }: let
  inherit (lib)
    mkOption
    types;
  in {
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
    default = pkgs.callPackage ./utils.nix {};
    description = "Preconfigured utils";
  };
  config = {};
}
