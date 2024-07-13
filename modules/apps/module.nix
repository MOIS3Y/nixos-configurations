# █▀▄▀█ █▀█ █▀▄ █░█ █░░ █▀▀ ▀
# █░▀░█ █▄█ █▄▀ █▄█ █▄▄ ██▄ ▄
# -- -- -- --- -- -- -- -- --

{ config, pkgs, lib, ... }: let
  utils = pkgs.callPackage ./utils { };
  scripts = pkgs.callPackage ./scripts { inherit config utils; };
  apps = with utils; {
    terminal = kitty;
    spare-terminal = wezterm;
    browser =  firefox;
    launcher = wofi;
    lockscreen = hyprlock;
    filemanager = nautilus;
    visual-text-editor = vscode; 
  };
in {
  options.apps = with lib; {
    scripts = mkOption {
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
      default = scripts;
      description = "Preconfigured scripts";
    };
    utils = mkOption {
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
      default = utils;
      description = "Preconfigured utils";
    };
    terminal = mkOption {
      type = with types; oneOf [
        str
        path
      ];
      default = apps.terminal;
      description = "default terminal";
    };
    spare-terminal = mkOption {
      type = with types; oneOf [
        str
        path
      ];
      default = apps.terminal;
      description = "default terminal";
    };
    browser = mkOption {
      type = with types; oneOf [
        str
        path
      ];
      default = apps.browser;
      description = "default browser";
    };
    filemanager = mkOption {
      type = with types; oneOf [
        str
        path
      ];
      default = apps.filemanager;
      description = "default filemanager";
    };
    launcher = mkOption {
      type = with types; oneOf [
        str
        path
      ];
      default = apps.launcher;
      description = "default launcher";
    };
    lockscreen = mkOption {
      type = with types; oneOf [
        str
        path
      ];
      default = apps.lockscreen;
      description = "default lockscreen";
    };
    visual-text-editor = mkOption {
      type = with types; oneOf [
        str
        path
      ];
      default = apps.visual-text-editor;
      description = "default visual text editor";
    };
  };
  config = {};
}
