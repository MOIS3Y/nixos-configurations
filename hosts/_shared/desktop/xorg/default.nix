# ▀▄▀ █▀█ █▀█ █▀▀ ▀
# █░█ █▄█ █▀▄ █▄█ ▄
# -- -- -- -- -- --

{ config, pkgs, lib, ... }: let
  cfg = config.desktop.xorg;
  windowManagers = {
    awesome = {
      enable = true;
      luaModules = [
        pkgs.lua52Packages.lgi
      ];
    };
    qtile = { 
      enable = true;
      extraPackages = python3Packages: with python3Packages; [
        psutil
        requests
      ];
    };
    # add more WM here ...
  };
in {
  options.desktop.xorg = with lib; {
    enable = mkEnableOption "Enable X11 environment";
    touchpad = mkEnableOption "Enable touchpad support services";
    windowManager = mkOption {
      type = with types; listOf (enum [ "awesome" "qtile" ]);
      default = [ "awesome" ];
      description = "List of preconfigured window managers";
      example = literalExpression ''
        windowManager = [ "awesome" "qtile" ];
      '';
    };
    videoDrivers = mkOption {
      type = types.listOf types.str;
      default = [ "modesetting" "fbdev" ];
      example = [
        "intel"
        "amdgpu"
      ];
    };
  };
  config = with pkgs; with lib; mkIf cfg.enable {
    services.xserver = {
      enable = true;
      windowManager = attrsets.getAttrs cfg.windowManager windowManagers;
      videoDrivers = cfg.videoDrivers;
      xkb = {
        variant = "";
        options = "grp:alt_shift_toggle";
        layout = "us,ru";
      };
      deviceSection = ''
        Option "DRI" "3"
        Option "VariableRefresh" "true"
      '';
      exportConfiguration = true;
    };
    services.libinput = {
      enable = true;
      touchpad = {
        naturalScrolling = true;
        tapping = true;              # default true
        scrollMethod = "twofinger";  # default "twofinger"
        disableWhileTyping = true;   # default false
      };
    };
    services.touchegg.enable = cfg.touchpad;
    systemd.user.services = mkIf cfg.touchpad {
      touchegg-client = {
        description = "Touchégg. The client.";
        wantedBy = pkgs.lib.mkForce [];
        partOf = [ "graphical-session.target" ];
        serviceConfig = {
          Type = "simple";
          ExecStart = "${getExe touchegg}";
        };
      };
    };
  };
}
