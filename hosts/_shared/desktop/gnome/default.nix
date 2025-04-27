# █▀▀ █▄░█ █▀█ █▀▄▀█ █▀▀ ▀
# █▄█ █░▀█ █▄█ █░▀░█ ██▄ ▄
# -- -- -- -- -- -- -- -- 

{ pkgs, ... }: {
  # dependencies:
  services.gvfs.enable = true;
  services.dleyna.enable = true;
  services.geoclue2.enable = true;
  services.geoclue2.enableDemoAgent = false; # GNOME has its own geoclue agent

  # services:
  services.gnome = {
    at-spi2-core.enable = true;
    sushi.enable = true;
    gnome-keyring.enable = true;
    evolution-data-server.enable = true;
    gnome-online-accounts.enable = true;
    localsearch.enable = true;
  };
  # programs:
  programs = {
    dconf.enable = true;  # required for gnome;
    file-roller.enable = true;
    geary.enable = true;
  };
  # pkgs:
  environment.systemPackages = with pkgs; [
    at-spi2-atk  # required for polkit-gnome-authentication-agent-1
    adwaita-icon-theme  # required for most gnome apps
    evince
    glib  # required for gnome-weather
    nautilus
    gnome-calculator
    gnome-calendar
    gnome-online-accounts-gtk
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
        ExecStart = with pkgs; ''
          ${evolution-data-server}/libexec/evolution-data-server/evolution-alarm-notify
        '';
      };
    };
  };
}
