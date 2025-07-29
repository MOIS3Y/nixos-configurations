# █░█ █ █▀█ ▀█▀ █░█ ▄▀█ █░░ █ ▀█ ▄▀█ ▀█▀ █ █▀█ █▄░█ ▀
# ▀▄▀ █ █▀▄ ░█░ █▄█ █▀█ █▄▄ █ █▄ █▀█ ░█░ █ █▄█ █░▀█ ▄
# -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- 

{ config, pkgs, lib, ... }: let
  cfg = config.host.virtualisation;
  inherit (lib)
    mkForce
    mkIf
    attrsets;
in {
  virtualisation.libvirtd = {
    enable = mkIf cfg.libvirtd.enable true;
  };
  virtualisation.docker = {
    enable = mkIf cfg.docker.enable true;
  };
  systemd.services = {
    libvirtd.wantedBy = mkIf cfg.libvirtd.startWhenNeeded (mkForce []);
    libvirt-guests.wantedBy = mkIf cfg.libvirtd.startWhenNeeded (mkForce []);
    docker.wantedBy = mkIf cfg.docker.startWhenNeeded (mkForce []);
  };
  virtualisation.oci-containers = {
    backend = "docker";
    containers = attrsets.getAttrs cfg.docker.oci-containers (
      import ./oci-containers.nix { inherit config pkgs;}
    );
  };
}
