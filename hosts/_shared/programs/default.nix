# █▀█ █▀█ █▀█ █▀▀ █▀█ ▄▀█ █▀▄▀█ █▀ ▀
# █▀▀ █▀▄ █▄█ █▄█ █▀▄ █▀█ █░▀░█ ▄█ ▄
# -- -- -- -- -- -- -- -- -- -- -- -

{ config, pkgs, lib, ... }: let
  cfg = config.host;
  inherit (lib)
    mkOption
    types;
in {
  options.host.flake = mkOption {
    type = types.nullOr types.path;
    default = null;
    description = ''
      The path that will be used for the `FLAKE` environment variable.
      `FLAKE` is used by nh as the default flake for performing actions,
      like `nh os switch`.
    '';
  };
  config = {
    programs = {
      nh = {
        enable = true;
        flake = cfg.flake;
      };
      ssh = {
        startAgent = true;
      };
      zsh = {
        enable = true;
      };
    };
  };
}
