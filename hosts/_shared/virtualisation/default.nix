# █░█ █ █▀█ ▀█▀ █░█ ▄▀█ █░░ █ ▀█ ▄▀█ ▀█▀ █ █▀█ █▄░█ ▀
# ▀▄▀ █ █▀▄ ░█░ █▄█ █▀█ █▄▄ █ █▄ █▀█ ░█░ █ █▄█ █░▀█ ▄
# -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- 

{ config, pkgs, lib, ... }: let
  cfg = config.host.virtualisation;
in {
  options.host.virtualisation = with lib; {
    libvirtd = {
      enable = mkEnableOption "Enable KVM";
      startWhenNeeded = mkEnableOption ''
        Systemd will only start the daemon
        if the user runs KVM related utilities
        Under the hood this removes wantedBy.
        libvirtd.wantedBy = lib.mkForce [];
        libvirt-guests.wantedBy = lib.mkForce [];
      '';
    };
    docker = {
      enable = mkEnableOption "Enable Docker";
      startWhenNeeded = mkEnableOption ''
        Systemd will only start the daemon
        if the user runs Docker related utilities
        Under the hood this removes wantedBy.
        docker.wantedBy = lib.mkForce [];
      '';
      oci-containers = mkOption {
        type = with types; listOf (enum [ "portainer-agent" ]);
        default = [];
        description = "List of preconfigured oci-containers";
        example = literalExpression ''
          host.virtualisation.oci-containers = [ "portainer-agent" ];
        '';
      };
    };
  };
  config = with lib; {
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
  };
}
