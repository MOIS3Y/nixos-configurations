# █▀▀ ▄▀█ █▀▄▀█ █▀▀ █▀ ▀
# █▄█ █▀█ █░▀░█ ██▄ ▄█ ▄
# -- -- -- -- -- -- -- -

{ config, pkgs, lib, ... }: let
  cfg = config.desktop.games;
  in lib.mkIf cfg.enable {
  programs.steam = {
    enable = true;
    extest.enable = lib.mkIf config.desktop.wayland.enable true;
    gamescopeSession = {
      enable = true;
    };
  };
  environment.systemPackages = [ pkgs.protonup-qt ] ++ cfg.extraPackages;
  hardware.xpadneo.enable = cfg.xpadneo.enable;
  systemd = lib.mkIf cfg.externalStorage.enable {
    mounts = [
      {
        description = "Volume for storing installed games";
        what = cfg.externalStorage.storagePath;
        where = cfg.externalStorage.mountPath;
        type = "ext4";
        options = "user,rw,exec,noatime,nofail,x-systemd.idle-timeout=30s";
      }
    ];
    automounts = [
      {
        description = "Mount on-demand storage for games";
        where = cfg.externalStorage.mountPath;
        automountConfig = {
          TimeoutIdleSec = 30;
        };
        wantedBy = [ "multi-user.target" ];
      }
    ];
  };
}
