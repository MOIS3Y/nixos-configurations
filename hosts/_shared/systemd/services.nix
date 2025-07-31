# █▀ █▀▀ █▀█ █░█ █ █▀▀ █▀▀ █▀ ▀
# ▄█ ██▄ █▀▄ ▀▄▀ █ █▄▄ ██▄ ▄█ ▄
# -- -- -- -- -- -- -- -- -- --

{ config, lib, ... }: let 
  cfg = config.host.virtualisation;
  inherit (lib)
    mkForce
    mkIf;
in {
    systemd.services = {
      # ? disable autostart virtualisation services if startWhenNeeded is true
      libvirtd.wantedBy = mkIf cfg.libvirtd.startWhenNeeded (mkForce []);
      libvirt-guests.wantedBy = mkIf cfg.libvirtd.startWhenNeeded (mkForce []);
      docker.wantedBy = mkIf cfg.docker.startWhenNeeded (mkForce []);
  };
}
