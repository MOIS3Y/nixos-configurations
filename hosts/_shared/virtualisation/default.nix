# █░█ █ █▀█ ▀█▀ █░█ ▄▀█ █░░ █ ▀█ ▄▀█ ▀█▀ █ █▀█ █▄░█ ▀
# ▀▄▀ █ █▀▄ ░█░ █▄█ █▀█ █▄▄ █ █▄ █▀█ ░█░ █ █▄█ █░▀█ ▄
# -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- 

{ config, pkgs, lib, ... }: let
  cfg = config.host.virtualisation;
in {
  virtualisation.libvirtd = {
    enable = cfg.libvirtd.enable;
  };
  virtualisation.docker = {
    enable = cfg.docker.enable;
  };
  virtualisation.oci-containers = {
    backend = "docker";
    containers = lib.attrsets.getAttrs cfg.docker.oci-containers (
      import ./oci-containers.nix { inherit config pkgs;}
    );
  };
}
