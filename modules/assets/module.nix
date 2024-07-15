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
    icons = mkOption {
      type = with types; oneOf [
        str
        path
      ];
      default = "${assets}/share/icons";
      description = "short path to icons into an assets package";
    };
    sounds = mkOption {
      type = with types; oneOf [
        str
        path
      ];
      default = "${assets}/share/sounds";
      description = "short path to sounds into an assets package";
    };
  };
  config = {};
}
