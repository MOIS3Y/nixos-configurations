# █░█ █▀ █▀▀ █▀█ ▄▄ █▀ █▀▀ █▀█ █░█ █ █▀▀ █▀▀ █▀ ▀
# █▄█ ▄█ ██▄ █▀▄ ░░ ▄█ ██▄ █▀▄ ▀▄▀ █ █▄▄ ██▄ ▄█ ▄
# -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -

{ config, pkgs, ... }: {
  systemd.user.services = { 
    indicatorapp = {
      description = "indicator-application-gtk3";
      wantedBy = [ "graphical-session.target" ];
      partOf = [ "graphical-session.target" ];
      serviceConfig = {
        ExecStart = "${pkgs.indicator-application-gtk3}/libexec/indicator-application/indicator-application-service";
      };
    };
  };
}
