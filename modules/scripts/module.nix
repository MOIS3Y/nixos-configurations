# █▀▄▀█ █▀█ █▀▄ █░█ █░░ █▀▀ ▀
# █░▀░█ █▄█ █▄▀ █▄█ █▄▄ ██▄ ▄
# -- -- -- --- -- -- -- -- --

{ config, pkgs, lib, ... }: let
  utils = pkgs.callPackage ./utils.nix { };
  scripts = {
    hypridle = pkgs.callPackage ./hypridle.nix { inherit utils; };
    khal = pkgs.callPackage ./khal.nix { inherit config utils; };
    lf = pkgs.callPackage ./lf.nix { inherit config utils; };
    ssh = pkgs.callPackage ./ssh.nix { inherit config utils; };
    wlogout = pkgs.callPackage ./wlogout.nix { inherit utils; };
    # add more default scripts here ...
  };
in {
  options.helpers = with lib; {
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
