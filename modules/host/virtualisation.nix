# █░█ █ █▀█ ▀█▀ █░█ ▄▀█ █░░ █ ▀█ ▄▀█ ▀█▀ █ █▀█ █▄░█ ▀
# ▀▄▀ █ █▀▄ ░█░ █▄█ █▀█ █▄▄ █ █▄ █▀█ ░█░ █ █▄█ █░▀█ ▄
# -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- 

{ lib, ... }: let
  inherit (lib)
    mkOption
    mkEnableOption
    types
    literalExpression;
in {
  options.host.virtualisation = {
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
        type = types.listOf (types.enum [ "portainer-agent" ]);
        default = [];
        description = "List of preconfigured oci-containers";
        example = literalExpression ''
          host.virtualisation.oci-containers = [ "portainer-agent" ];
        '';
      };
    };
  };
  config = {};
}
