# █▀ █▀█ █▀█ █▀ ▀
# ▄█ █▄█ █▀▀ ▄█ ▄
# -- -- -- -- -- 

{ inputs, config, pkgs, ... }: {
  imports = [
    ../../_shared/sops
  ];
  defaultHostSopsFile = ../../../secrets/hosts/vps-gliese/secrets.yaml;
  sops = {
    secrets = {
      admserv-password = {
        neededForUsers = true;
      };
    };
  };
}
