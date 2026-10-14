# █░█ █▀█ █▀ ▀█▀ ▀
# █▀█ █▄█ ▄█ ░█░ ▄
# -- -- -- -- -- -
# Global configuration options for host-specific hardware and services.

{ lib, ... }:
let
  inherit (lib)
    mkOption
    mkEnableOption
    types
    literalExpression
    ;
in
{
  options.host = {
    boot = {
      grubTheme = mkOption {
        type = types.enum [
          "gigabyte"
          "huawei"
          "msi"
          "nixos"
        ];
        default = "nixos";
        description = "Name of grub theme to be used.";
      };
    };

    flake = mkOption {
      type = types.nullOr types.path;
      default = null;
      description = ''
        The path that will be used for the `NH_FLAKE` environment variable.
        `NH_FLAKE` is used by nh as the default flake for performing actions,
        like `nh os switch`.
      '';
    };

    hardware = {
      bluetooth = {
        enable = mkEnableOption "Whether to enable bluetooth services";
      };
      gpu = {
        enable = mkEnableOption "Whether to enable GPU services";
      };
      graphics = {
        enable = mkEnableOption "Whether to enable OpenGL";
      };
      openRGB = {
        enable = mkEnableOption "Whether to enable openRGB service";
      };
      coolercontrol = {
        enable = mkEnableOption "Whether to enable coolercontrol program";
      };
      ddcci = {
        enable = mkEnableOption "Whether to enable ddcci for external monitors";
      };
    };

    users = mkOption {
      type = types.listOf (types.enum [ "stepan" ]);
      default = [ "stepan" ];
      description = "List of preconfigured users";
      example = literalExpression "host.users = [ \"stepan\" ];";
    };

    virtualisation = {
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
  };

  config = { };
}
