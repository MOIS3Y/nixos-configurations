# █▀ █▄█ █▀ ▀█▀ █▀▀ █▀▄▀█ █▀▄ ▀
# ▄█ ░█░ ▄█ ░█░ ██▄ █░▀░█ █▄▀ ▄
# -- -- -- -- -- -- -- -- -- --
# Defines custom systemd services, automounts, mounts and tmpfiles.

{
  config,
  pkgs,
  lib,
  ...
}:
let
  inherit (lib) mkForce optionalAttrs;
  inherit (config.services) desktopManager;
in
{
  systemd.automounts = [
    # add base systemd automounts here ...
  ]
  ++ lib.optionals (config.desktop.games.enable or null != null) [
    (lib.mkIf config.desktop.games.externalStorage.enable {
      description = "Mount on-demand storage for games";
      where = config.desktop.games.externalStorage.mountPath;
      automountConfig = {
        TimeoutIdleSec = 30;
      };
      wantedBy = [ "multi-user.target" ];
    })
  ];

  systemd.mounts = [
    # add base systemd mounts here ...
  ]
  ++ lib.optionals (config.desktop.games.enable or null != null) [
    (lib.mkIf config.desktop.games.externalStorage.enable {
      description = "Volume for storing installed games";
      what = config.desktop.games.externalStorage.storagePath;
      where = config.desktop.games.externalStorage.mountPath;
      type = "ext4";
      options = "user,rw,exec,noatime,nofail,x-systemd.idle-timeout=30s";
    })
  ];

  systemd.services = {
    # add base systemd services here ...
  }
  // optionalAttrs config.virtualisation.libvirtd.enable {
    # Keep socket activation without starting libvirt or restoring guests at boot.
    libvirtd.wantedBy = mkForce [ ];
    libvirt-guests.wantedBy = mkForce [ ];
  };

  systemd.tmpfiles.settings = {
    # add base systemd tmpfiles settings here ...
  }
  // optionalAttrs config.services.greetd.enable {
    "10-mdgreet" = {
      "/var/cache/mdgreet".d = {
        mode = "0755";
        user = "greeter";
        group = "greeter";
      };
      "/var/log/mdgreet".d = {
        mode = "0755";
        user = "greeter";
        group = "greeter";
      };
    };
  };

  systemd.user.services = {
    # add base systemd user services here ...
  }
  // optionalAttrs (config.desktop.enable && !desktopManager.gnome.enable) {
    dcal = {
      description = "Dux Calendar";
      wantedBy = [ "graphical-session.target" ];
      partOf = [ "graphical-session.target" ];
      after = [ "graphical-session.target" ];
      path = [ pkgs.quickshell ];
      unitConfig = {
        StartLimitIntervalSec = 60;
        StartLimitBurst = 5;
      };
      serviceConfig = {
        Type = "simple";
        ExecStart = "${lib.getExe pkgs.dux-calendar} run --session --hidden";
        Restart = "on-failure";
        RestartSec = 2;
        Slice = "app.slice";
      };
    };
    polkit-gnome-authentication-agent-1 = {
      description = "polkit-gnome-authentication-agent-1";
      wantedBy = [ "graphical-session.target" ];
      wants = [ "graphical-session.target" ];
      after = [ "graphical-session.target" ];
      serviceConfig = {
        Type = "simple";
        ExecStart = "${pkgs.polkit_gnome}/libexec/polkit-gnome-authentication-agent-1";
      };
    };
    evolution-alarm-notify = {
      wantedBy = [ "graphical-session.target" ];
    };
  };
}
