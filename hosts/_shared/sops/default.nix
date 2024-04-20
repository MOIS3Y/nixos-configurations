# █▀ █▀█ █▀█ █▀ ▀
# ▄█ █▄█ █▀▀ ▄█ ▄
# -- -- -- -- -- 

{ inputs, config, pkgs, lib, ... }: {
  imports = [
    inputs.sops-nix.nixosModules.sops
  ];
  options = {
    defaultHostSopsFile = lib.mkOption {
      type = lib.types.path;
      example = secrets/secrets.yaml;
      description = "path to the file with secrets";
    };
  };
  config = {
    sops = {
      defaultSopsFile = config.defaultHostSopsFile;
    };
  };
}
