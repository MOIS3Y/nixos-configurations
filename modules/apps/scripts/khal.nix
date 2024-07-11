# █▄▀ █░█ ▄▀█ █░░ ▀
# █░█ █▀█ █▀█ █▄▄ ▄
# -- -- -- -- -- --

{ config, pkgs, utils, ... }: with utils; {
  googleCalendarFetchId = pkgs.writeShellScript "khal-gcfid.sh" ''
    ${cat} ${config.sops.secrets."google-calendar/fetch-id".path}
  '';
  googleCalendarFetchSecret = pkgs.writeShellScript "khal-gcfs.sh" ''
    ${cat} ${config.sops.secrets."google-calendar/fetch-secret".path}
  '';
}
