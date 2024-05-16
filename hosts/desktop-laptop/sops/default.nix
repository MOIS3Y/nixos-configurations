# █▀ █▀█ █▀█ █▀ ▀
# ▄█ █▄█ █▀▀ ▄█ ▄
# -- -- -- -- -- 

{ inputs, config, pkgs, ... }: {
  imports = [
    ../../_shared/sops
  ];
  defaultHostSopsFile = ../../../secrets/hosts/desktop-laptop/secrets.yaml;
  sops = {
    secrets = {
      stepan-password = {
        neededForUsers = true;
      };
    };
  };
}
