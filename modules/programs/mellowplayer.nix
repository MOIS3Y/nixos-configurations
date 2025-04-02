# █▀▄▀█ █▀▀ █░░ █░░ █▀█ █░█░█   █▀█ █░░ ▄▀█ █▄█ █▀▀ █▀█ ▀
# █░▀░█ ██▄ █▄▄ █▄▄ █▄█ ▀▄▀▄▀   █▀▀ █▄▄ █▀█ ░█░ ██▄ █▀▄ ▄
# -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -

{ config, pkgs, lib, ... }: let
  cfg = config.programs.mellowplayer;
  iniFormat = pkgs.formats.ini {};
  inherit (lib)
    mkEnableOption
    mkOption
    literalExpression
    types;
  in {
  options.programs.mellowplayer = {
    enable = mkEnableOption "enable MellowPlayer";
    package = mkOption {
      type = types.package;
      default = pkgs.mellowplayer;
      description = ''
        MellowPlayer is a free, open source and cross-platform desktop 
        application that runs web-based music streaming services in 
        its own window and provides integration with your desktop
        (hotkeys, multimedia keys, system tray,notifications and more).
      '';
    };
    settings = mkOption {
      type = iniFormat.type;
      default = {};
      description = ''
        The settings specified here will be converted to .ini
        Please note that Mellow Player writes values to the conf file on the fly.
        If you make changes at runtime,
        they will be changed before closing the program;
        restarting will launch the program with the parameters specified here.
      '';
      example = literalExpression ''
        settings = {
          General = { zoom = 1;};
          Youtube = { favorite = true; };
          main = { close-to-tray = true; };
          notifications = { enabled = true; };
          privacy = { enable-listening-history = true; };
          private = {
            remote-control-enabled = false;
            show-close-to-tray-message = false;
            show-favorite-services = true;
          };
          appearance = {
            theme = "Custom";
            toolbar-visible = true;
            show-tray-icon = true;
            accent = "#89b4fa";
            background = "#1e1e2e";
            foreground = "#cdd6f4";
            primary-background = "#11111b";
            primary-foreground = "#cdd6f4";
            secondary-background = "#11111b";
            secondary-foreground = "#cdd6f4";
          };
      '';
    };
  };
  config = lib.mkIf cfg.enable {
    home.packages = [ cfg.package ];
    xdg.configFile = {
      "MellowPlayer/MellowPlayer3.conf".source = (
        iniFormat.generate "mellowplayer-config" cfg.settings
      );
    };
  };
}
