# █▀ █░█ █░█ ▀█▀ █▀▄ █▀█ █░█░█ █▄░█ ▀
# ▄█ █▀█ █▄█ ░█░ █▄▀ █▄█ ▀▄▀▄▀ █░▀█ ▄
# -- -- -- -- -- -- -- -- -- -- -- --

# The module is just a temporary solution
# to the problem of stopping background processes.
# therefore, to exit the application correctly,
# we need a tool that would stop background processes
# Nix-on-droid currently does not have an initialization system:
# https://github.com/nix-community/nix-on-droid/issues/54

{ config, pkgs, lib, ... }: let
  cfg = config.programs.shutdown;
  inherit (lib)
  mkEnableOption
  mkOption
  mkIf
  types;

  concatServices = list: builtins.concatStringsSep " " list;
  shutdown = pkgs.writeScriptBin "shutdown" ''
    #!${pkgs.runtimeShell}
    services="${concatServices cfg.services}"
    for service in $services
    do
      if ! ${pkgs.killall}/bin/killall "$service" >> /dev/null 2>&1; then
        echo "$service has already stopped"
      else
        echo "$service stopped"
      fi
    done
    echo "All background services have been stopped"
    echo "Bye!"
    exit
  '';
in {
  options.programs.shutdown = {
    enable = mkEnableOption "Whether to enable the shutdown program";
    services = mkOption {
      type = types.listOf types.str;
      default = [ ];
      description = ''
        List of services that will be stopped before logging out.
      '';
    };
  };
  config = mkIf cfg.enable {
    environment.packages = [
      shutdown
    ];
  };
}
