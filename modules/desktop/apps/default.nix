# ▄▀█ █▀█ █▀█ █▀ ▀
# █▀█ █▀▀ █▀▀ ▄█ ▄
# -- -- -- -- -- -

{ config, pkgs, lib, ... }: let
  inherit (lib)
    mkOption
    types;
  in {
  options.desktop.apps = {
    terminal = mkOption {
      type = with types; oneOf [
        str
        path
      ];
      description = "default terminal";
    };
    spare-terminal = mkOption {
      type = with types; oneOf [
        str
        path
      ];
      description = "spare terminal";
    };
    browser = mkOption {
      type = with types; oneOf [
        str
        path
      ];
      description = "default browser";
    };
    filemanager = mkOption {
      type = with types; oneOf [
        str
        path
      ];
      description = "default filemanager";
    };
    launcher = mkOption {
      type = with types; oneOf [
        str
        path
      ];
      description = "default launcher";
    };
    lockscreen = mkOption {
      type = with types; oneOf [
        str
        path
      ];
      description = "default lockscreen";
    };
    visual-text-editor = mkOption {
      type = with types; oneOf [
        str
        path
      ];
      description = "default visual text editor";
    };
  };
  config = {};
}
