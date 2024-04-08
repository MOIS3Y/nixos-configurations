# █▀ █▀█ █▀█ █▀ ▀
# ▄█ █▄█ █▀▀ ▄█ ▄
# -- -- -- -- -- 

{ inputs, config, pkgs, ... }: {
  imports = [
    inputs.sops-nix.nixosModules.sops
  ];
  # default:
  sops.defaultSopsFile = ../../../secrets/primary/secrets.yaml;
  sops.age.keyFile = /opt/secrets/age/keys.txt;
  # secrets:
  sops.secrets.admserv-password = {
    sopsFile = ../../../secrets/primary/secrets.yaml;
    neededForUsers = true;
  };
}
