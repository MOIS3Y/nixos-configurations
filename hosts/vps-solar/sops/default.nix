# █▀ █▀█ █▀█ █▀ ▀
# ▄█ █▄█ █▀▀ ▄█ ▄
# -- -- -- -- -- 

{ inputs, config, pkgs, ... }: {
  imports = [
    ../../_shared/sops
  ];
  defaultHostSopsFile = ../../../secrets/hosts/vps-solar/secrets.yaml;
  sops = {
    secrets = {
      admserv-password = {
        neededForUsers = true;
      };
    };
  };
}
