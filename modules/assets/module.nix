# █▀▄▀█ █▀█ █▀▄ █░█ █░░ █▀▀ ▀
# █░▀░█ █▄█ █▄▀ █▄█ █▄▄ ██▄ ▄
# -- -- -- --- -- -- -- -- --

{ inputs, config, pkgs, lib, ... }: let
  cfg = config.desktop.assets;
  assets = inputs.assets4nix.packages."${pkgs.system}".assets4nix;
  cs = config.colorScheme.name;
in {
  options.desktop.assets = with lib; {
    package = mkOption {
      type = types.package;
      default = assets;
      defaultText = literalExpression "pkgs.assets4nix";
      description = "package containing resources (wallpaper, icons, sounds)";
    };
    # Images staff:
    images = {
      wallpapers = mkOption {
        type = with types; oneOf [
          str
          path
        ];
        default = "${assets}/share/images/wallpapers";
        description = "short path to wallpapers into an assets package";
      };
      backgrounds = mkOption {
        type = with types; oneOf [
          str
          path
        ];
        default = "${assets}/share/images/backgrounds";
        description = "short path to backgrounds into an assets package";
      };
      # Default:
      wallpaper = mkOption {
        type = with types; oneOf [
          str
          path
        ];
        default = "${assets}/share/images/wallpapers/hexagon/${cs}.png";
        description = "default wallpaper";
      };
      background = mkOption {
        type = with types; oneOf [
          str
          path
        ];
        default = "${assets}/share/images/backgrounds/hexagon/${cs}.png";
        description = "default background image";
      };
    };
    # Icons staff:
    icons = mkOption {
      type = with types; oneOf [
        str
        path
      ];
      default = "${assets}/share/icons";
      description = "short path to icons into an assets package";
    };
    # Sounds stuff:
    sounds = {
      alarm = mkOption {
        type = with types; oneOf [
          str
          path
        ];
        default = "${assets}/share/sounds/alarm";
        description = "short path to alarm sounds into an assets package";
      };
      notifications = mkOption {
        type = with types; oneOf [
          str
          path
        ];
        default = "${assets}/share/sounds/notifications";
        description = "short path to notifications sounds into an assets package";
      };
      system = mkOption {
        type = with types; oneOf [
          str
          path
        ];
        default = "${assets}/share/sounds/system";
        description = "short path to alarm sounds into an assets package";
      };
      # Beeppers:
      toggle-beep = mkOption {
        type = with types; oneOf [
          str
          path
        ];
        default = "${assets}/share/sounds/system/sly.mp3";
        description = "system sound of toggle actions";
      };
      switch-beep = mkOption {
        type = with types; oneOf [
          str
          path
        ];
        default = "${assets}/share/sounds/system/knob.mp3";
        description = "system sound for switch actions";
      };
      open-beep = mkOption {
        type = with types; oneOf [
          str
          path
        ];
        default = "${assets}/share/sounds/system/opening.mp3";
        description = "system sound for switch actions";
      };
      volume-beep = mkOption {
        type = with types; oneOf [
          str
          path
        ];
        default = "${assets}/share/sounds/system/all-eyes-on-me.mp3";
        description = "system sound of volume change";
      };
      # Notifications:
      warning-notification = mkOption {
        type = with types; oneOf [
          str
          path
        ];
        default = "${assets}/share/sounds/alarm/answer-quickly.mp3";
        description = "notification sound with critical status";
      };
    }; 
  };
  config = {};
}
