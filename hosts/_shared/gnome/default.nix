# █▀▀ █▄░█ █▀█ █▀▄▀█ █▀▀ ▀
# █▄█ █░▀█ █▄█ █░▀░█ ██▄ ▄
# -- -- -- -- -- -- -- -- 

{ config, pkgs, lib, ... }: {
  # dependencies:
  services.gvfs.enable = true;
  services.dleyna-server.enable = true;
  services.dleyna-renderer.enable = true;
  services.geoclue2.enable = true;
  services.geoclue2.enableDemoAgent = false; # GNOME has its own geoclue agent
  services.sysprof.enable = true;

  # services:
  services.gnome = {
    at-spi2-core.enable = true;
    sushi.enable = true;
    gnome-keyring.enable = true;
    evolution-data-server.enable = true;
    gnome-online-accounts.enable = true;
    gnome-online-miners.enable = true;
    tracker-miners.enable = true;
    gnome-settings-daemon.enable = true;
    gnome-user-share.enable = true;
    glib-networking.enable = true;
    rygel.enable = true;
    core-os-services.enable = true;  # if I foget something:)
  };
  # programs:
  programs = {
    dconf.enable = true;  # required for gnome;
    file-roller.enable = true;
    geary.enable = true;
  };
  # pkgs:
  environment.systemPackages = with pkgs; [
    glib # for gsettings program
    at-spi2-atk  # required for polkit-gnome-authentication-agent-1
    gnome.adwaita-icon-theme  # required for most gnome apps
    gnome-online-accounts-gtk
    gnome.gnome-backgrounds
    gnome.gnome-bluetooth
    gnome.nautilus
    gnome.gnome-calendar
    gnome.gnome-calculator
    gnome.gnome-control-center
    gnome.gnome-weather
  ] ++ lib.optionals config.services.flatpak.enable [
      # Since PackageKit Nix support is not there yet,
      # only install gnome-software if flatpak is enabled.
      gnome-software
    ];
  # daemons:
  systemd.user.services = { 
    polkit-gnome-authentication-agent-1 = {
      description = "polkit-gnome-authentication-agent-1";
      wantedBy = [ "graphical-session.target" ];
      wants = [ "graphical-session.target" ];
      after = [ "graphical-session.target" ];
      serviceConfig = {
        Type = "simple";
        ExecStart = ''
          ${pkgs.polkit_gnome}/libexec/polkit-gnome-authentication-agent-1
        '';
      };
    };
    evolution-alarm-notify = {
      description = "evolution-alarm-notify daemon for get alarm reminders";
      wantedBy = [ "graphical-session.target" ];
      wants = [ "graphical-session.target" ];
      after = [ "graphical-session.target" ];
      serviceConfig = {
        Type = "simple";
        ExecStart = with pkgs.gnome; ''
          ${evolution-data-server}/libexec/evolution-data-server/evolution-alarm-notify
        '';
      };
    };
  };
}
