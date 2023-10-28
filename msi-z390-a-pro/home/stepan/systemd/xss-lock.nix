# ▀▄▀ █▀ █▀ ▄▄ █░░ █▀█ █▀▀ █▄▀ ▀
# █░█ ▄█ ▄█ ░░ █▄▄ █▄█ █▄▄ █░█ ▄
# -- -- -- -- -- -- -- -- -- --

{ config, pkgs, ... }: {
  systemd.user.services.xss-lock = {
    Unit = {
      Description = "xss-lock, session locker service";
      After = [ "graphical-session-pre.target" ];
      PartOf = [ "graphical-session.target" ];
    };
    Install = { WantedBy = [ "graphical-session.target" ]; };
    Service = {
      ExecStart = with pkgs; ''
        ${xss-lock}/bin/xss-lock --session ''${XDG_SESSION_ID} \
        -- ${extrapkgs.i3lock-run}/bin/i3lock-run -s catppuccin_mocha -f Inter
      '';
      ExecStartPre = "${pkgs.xorg.xset}/bin/xset s off s noblank -dpms";
    };
  };
}
