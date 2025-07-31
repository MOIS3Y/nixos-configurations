# █▀ █▀▀ █▀█ █░█ █ █▀▀ █▀▀ █▀ ▀
# ▄█ ██▄ █▀▄ ▀▄▀ █ █▄▄ ██▄ ▄█ ▄
# -- -- -- -- -- -- -- -- -- --

{ config, lib, ... }: let 
  cfg = config.host.virtualisation;
  inherit (lib)
    mkForce
    mkIf
    optionalAttrs;
in {
    systemd.services = {
      # ? disable autostart virtualisation services if startWhenNeeded is true
      libvirtd.wantedBy = mkIf cfg.libvirtd.startWhenNeeded (mkForce []);
      libvirt-guests.wantedBy = mkIf cfg.libvirtd.startWhenNeeded (mkForce []);
      docker.wantedBy = mkIf cfg.docker.startWhenNeeded (mkForce []);
  }
  # optionals:
  // optionalAttrs config.services.greetd.enable {
    # ? yoinked from:
    # https://github.com/sjcobb2022/nixos-config/blob/main/hosts/common/optional/greetd.nix
    # https://codeberg.org/kye/nixos/src/branch/master/home/greetd/default.nix
    greetd.serviceConfig = {
      Type = "idle";
      StandardInput = "tty";
      StandardOutput = "tty";
      # Without this errors will spam on screen
      StandardError = "journal";
      # Without these boot logs will spam on screen
      TTYReset = true;
      TTYVHangup = true;
      TTYVTDisallocate = true;
    };
  };
}
