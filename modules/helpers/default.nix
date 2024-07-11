# █░█ █▀▀ █░░ █▀█ █▀▀ █▀█ █▀ ▀
# █▀█ ██▄ █▄▄ █▀▀ ██▄ █▀▄ ▄█ ▄
# -- -- -- -- -- -- -- -- -- -

{ config, pkgs, lib, ... }: let
  utils = pkgs.callPackage ./utils { };
  scripts = pkgs.callPackage ./scripts { inherit config; };
in {
  options.helpers = with lib; {
    utils = mkOption {
      type = with types;
        let
          valueType = nullOr (oneOf [
            str
            path
            (attrsOf valueType)
          ]) // {
            description = "attribute sets containing paths to exec files";
          };
        in valueType;
      default = utils;
      description = ''
        Option for quick access to executable files.
        It is necessary that if the path to the package 
        or the name of the executable file in the nixpkgs upstream changes,
        you can edit it in one place in the configuration and not search
        for where the definition is declared across all files.
      '';
      example = literalExpression ''
        {
          bash = "${getExe bash}";
          hyprctl = "${hyprland}/bin/hyprctl";
        };
      '';
    };
    scripts = mkOption {
      type = with types;
        let
          valueType = nullOr (oneOf [
            str
            path
            attrs
            (attrsOf valueType)
          ]) // {
            description = "";
          };
        in valueType;
      default = scripts;
      description = ''
      '';
    };
  };
  config = {};
}
