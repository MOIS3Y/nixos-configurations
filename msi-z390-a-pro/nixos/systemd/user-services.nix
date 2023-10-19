# █░█ █▀ █▀▀ █▀█ ▄▄ █▀ █▀▀ █▀█ █░█ █ █▀▀ █▀▀ █▀ ▀
# █▄█ ▄█ ██▄ █▀▄ ░░ ▄█ ██▄ █▀▄ ▀▄▀ █ █▄▄ ██▄ ▄█ ▄
# -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -

{ config, pkgs, extrapkgs, ... }: {
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
    xidlehook = {
      description = "Automatic Screen Locker";
      wantedBy = [ "graphical-session.target" ];
      partOf = [ "graphical-session.target" ];
      serviceConfig = {
        Type = "simple";
        Environment = [ "DISPLAY=:0" "XIDLEHOOK_SOCK=/tmp/xidlehook.socket" ];
        ExecStart = ''
          ${pkgs.xidlehook}/bin/xidlehook \
            --not-when-audio \
            --not-when-fullscreen \
            --socket $XIDLEHOOK_SOCK \
            --timer 600 '${extrapkgs.i3lock-run}/bin/i3lock-run -s catppuccin_mocha -f Inter' "" \
            --timer 60 'systemctl suspend' ""
        '';
      };
    };
    nm-applet = {
      description = "Network Manager applet";
      wantedBy = [ "network-online.target" "graphical-session.target" ];
      wants = [ "network-online.target" "graphical-session.target" ];
      after = [ "network-online.target" "graphical-session.target" ];
      partOf = [ "graphical-session.target" ];
      serviceConfig = {
        Type = "simple";
        ExecStart = "${pkgs.networkmanagerapplet}/bin/nm-applet";
      };
    };
    # ... add more user.services here:
  };
}
