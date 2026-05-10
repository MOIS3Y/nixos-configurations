# █░█ █ █▀█ ▀█▀ █░█ ▄▀█ █░░ █ ▀█ ▄▀█ ▀█▀ █ █▀█ █▄░█ ▀
# ▀▄▀ █ █▀▄ ░█░ █▄█ █▀█ █▄▄ █ █▄ █▀█ ░█░ █ █▄█ █░▀█ ▄
# -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- 

{ lib, ... }: let
  inherit (lib)
    mkEnableOption;
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
    };
  };
  config = {};
}
