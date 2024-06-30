# █▀ █▀█ █▀█ █▀ ▀
# ▄█ █▄█ █▀▀ ▄█ ▄
# -- -- -- -- -- 

{ inputs, config, pkgs, ... }: {
  imports = [
    ../../_shared/sops
  ];
  defaultHostSopsFile = ../../../secrets/hosts/vps-allsave/secrets.yaml;
  sops = {
    secrets = {
      admserv-password = {
        neededForUsers = true;
      };
    };
  };
}
