# █▀▀ █░░ ▄▀█ █▄▀ █▀▀ ▄▄ █▀█ ▄▀█ ▀█▀ █░█ ▀
# █▀░ █▄▄ █▀█ █░█ ██▄ ░░ █▀▀ █▀█ ░█░ █▀█ ▄
# -- -- -- -- -- -- -- -- -- -- -- -- -- -

{ lib, ... }: let
  inherit (lib)
    mkOption
    types;
in {
  options.host.flake = mkOption {
    type = types.nullOr types.path;
    default = null;
    description = ''
      The path that will be used for the `NH_FLAKE` environment variable.
      `NH_FLAKE` is used by nh as the default flake for performing actions,
      like `nh os switch`.
    '';
  };
  config = {};
}
