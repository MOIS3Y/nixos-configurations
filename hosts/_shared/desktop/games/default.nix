# █▀▀ ▄▀█ █▀▄▀█ █▀▀ █▀ ▀
# █▄█ █▀█ █░▀░█ ██▄ ▄█ ▄
# -- -- -- -- -- -- -- -

{ config, pkgs, lib, ... }: let
  cfg = config.desktop.games;
in {
  options.desktop.games = with lib; {
    xpadneo = mkOption {
      type = types.bool;
      default = true;
      description = "Enable gamepad support";
    };
    extraPackages = mkOption {
      type = types.listOf types.package;
      default = [];
      description = ''
        List of additional packages that will be installed with steam
        The list specified here will expand the standard list.
        protonup-qt is added by default.
      '';
      example = literalExpression ''
        with pkgs; [
          (lutris.override {
            extraPkgs = pkgs: with pkgs; [
              winePackages.unstableFull
            ];
          })
          bottles
        ];
      '';
    };
    externalStorage = {
      enable = mkEnableOption "Enable external storage";
      storagePath = mkOption {
        type = types.str;
        default = "/dev/disk/by-label/games";
        description = ''
          Path to the block device.
          It will be used by systemd as mounts.what.
        '';
      };
      mountPath = mkOption {
        type = types.str;
        default = "/home/stepan/Games";
        description = ''
          Path to the home directory where the storage will be mounted.
          It will be used by systemd as mounts.where automounts.where.
        '';
      };
    };
  };
  config = with pkgs; with lib; mkIf cfg.enable {
    programs.steam = {
      enable = true;
      extest.enable = mkIf config.desktop.wayland.enable true;
      gamescopeSession = {
        enable = true;
      };
    };
    environment.systemPackages = [ protonup-qt ] ++ cfg.extraPackages;
    hardware.xpadneo.enable = cfg.xpadneo;
    systemd = mkIf cfg.externalStorage.enable {
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
  };
}
