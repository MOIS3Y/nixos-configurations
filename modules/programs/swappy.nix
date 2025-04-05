# █▀ █░█░█ ▄▀█ █▀█ █▀█ █▄█ ▀
# ▄█ ▀▄▀▄▀ █▀█ █▀▀ █▀▀ ░█░ ▄
# -- -- -- -- -- -- -- -- --

{config, pkgs, lib, ...}: let
  cfg = config.programs.swappy;
  iniFormat = pkgs.formats.ini {};
  inherit (lib)
    mkEnableOption
    mkOption
    mkPackageOption
    literalExpression
    types;
  in {
  options.programs.swappy = {
    enable = mkEnableOption "Whether to enable swappy";
    package = mkPackageOption pkgs "swappy" {};
    extraPackages = mkOption {
      type = types.listOf types.package;
      default = [ ];
      description = ''
        List of additional packages that will be installed with swappy
      '';
      example = literalExpression ''
        extraPackages = with pkgs; [
          grim
          slurp
          wl-clipboard
        ];
      '';
    };
    settings = mkOption {
      type = iniFormat.type;
      default = {};
      description = ''
        The settings specified here will be converted to ini format.
        Full list of available options see in the readme file:
        https://github.com/jtheoof/swappy
      '';
      example = literalExpression ''
        settings = {
          Default = {
            save_dir = /home/username/Pictures/Screenshots
            save_filename_format = "%Y-%m-%d-%H-%M-%S.png"
            show_panel = false
            line_size = 3
            text_size = 20
            text_font = "sans-serif"
            early_exit = true
          };
        };
      '';
    };
  };
  config = lib.mkIf cfg.enable {
    home.packages = [ cfg.package ] ++ cfg.extraPackages;
    xdg.configFile = {
      "swappy/config".source = (
        iniFormat.generate "swappy-config" cfg.settings
      );
    };
  };
}
