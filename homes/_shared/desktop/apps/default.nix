# ▄▀█ █▀█ █▀█ █▀ ▀
# █▀█ █▀▀ █▀▀ ▄█ ▄
# -- -- -- -- -- -

{ config, pkgs, lib, ... }: with config.desktop; {
  options.desktop.apps = with lib; {
    terminal = mkOption {
      type = with types; oneOf [
        str
        path
      ];
      default = utils.kitty;
      description = "default terminal";
    };
    spare-terminal = mkOption {
      type = with types; oneOf [
        str
        path
      ];
      default = utils.wezterm;
      description = "spare terminal";
    };
    browser = mkOption {
      type = with types; oneOf [
        str
        path
      ];
      default = utils.firefox;
      description = "default browser";
    };
    filemanager = mkOption {
      type = with types; oneOf [
        str
        path
      ];
      default = utils.nautilus;
      description = "default filemanager";
    };
    launcher = mkOption {
      type = with types; oneOf [
        str
        path
      ];
      default = utils.wofi;
      description = "default launcher";
    };
    lockscreen = mkOption {
      type = with types; oneOf [
        str
        path
      ];
      default = utils.hyprlock;
      description = "default lockscreen";
    };
    visual-text-editor = mkOption {
      type = with types; oneOf [
        str
        path
      ];
      default = utils.vscode;
      description = "default visual text editor";
    };
  };
  config = {};
}
