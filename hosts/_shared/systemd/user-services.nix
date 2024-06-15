# █░█ █▀ █▀▀ █▀█ ▄▄ █▀ █▀▀ █▀█ █░█ █ █▀▀ █▀▀ █▀ ▀
# █▄█ ▄█ ██▄ █▀▄ ░░ ▄█ ██▄ █▀▄ ▀▄▀ █ █▄▄ ██▄ ▄█ ▄
# -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -

{ config, pkgs, extrapkgs, ... }: {
  # systemd.user.services = { 
  #   polkit-gnome-authentication-agent-1 = {
  #     description = "polkit-gnome-authentication-agent-1";
  #     wantedBy = [ "graphical-session.target" ];
  #     wants = [ "graphical-session.target" ];
  #     after = [ "graphical-session.target" ];
  #     serviceConfig = {
  #       Type = "simple";
  #       ExecStart = ''
  #         ${pkgs.polkit_gnome}/libexec/polkit-gnome-authentication-agent-1
  #       '';
  #     };
  #   };
    # indicatorapp = {
    #   description = "indicator-application-gtk3";
    #   wantedBy = pkgs.lib.mkForce [];
    #   partOf = [ "graphical-session.target" ];
    #   serviceConfig = {
    #     ExecStart = "${pkgs.indicator-application-gtk3}/libexec/indicator-application/indicator-application-service";
    #   };
    # };
    # touchegg-client = {
    #   description = "Touchégg. The client.";
    #   wantedBy = pkgs.lib.mkForce [];
    #   partOf = [ "graphical-session.target" ];
    #   serviceConfig = {
    #     Type = "simple";
    #     ExecStart = "${pkgs.touchegg}/bin/touchegg";
    #   };
    # };
    # xidlehook = {
    #   description = "Automatic Screen Locker";
    #   wantedBy = pkgs.lib.mkForce [];
    #   partOf = [ "graphical-session.target" ];
    #   serviceConfig = {
    #     Type = "simple";
    #     Environment = [ "DISPLAY=:0" "XIDLEHOOK_SOCK=/tmp/xidlehook.socket" ];
    #     ExecStart = ''
    #       ${pkgs.xidlehook}/bin/xidlehook \
    #         --not-when-audio \
    #         --not-when-fullscreen \
    #         --socket $XIDLEHOOK_SOCK \
    #         --timer 600 '${extrapkgs.i3lock-run}/bin/i3lock-run -s catppuccin_mocha -f Inter' "" \
    #         --timer 60 'systemctl suspend' ""
    #     '';
    #   };
    # };

    # ... add more user.services here:
  # };
}
