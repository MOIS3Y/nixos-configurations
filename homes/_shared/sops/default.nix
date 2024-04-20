# █▀ █▀█ █▀█ █▀ ▀
# ▄█ █▄█ █▀▀ ▄█ ▄
# -- -- -- -- -- 

{ inputs, config, pkgs, lib, ... }: {
  imports = [
    inputs.sops-nix.homeManagerModules.sops
  ];
  options = {
    defaultUserSopsFile = lib.mkOption {
      type = lib.types.path;
      example = secrets/secrets.yaml;
      description = "path to the file with secrets";
    };
  };
  config = {
    sops = {
      defaultSopsFile = config.defaultUserSopsFile;
      age = {
        keyFile = "${config.xdg.configHome}/sops/age/keys.txt";
        generateKey = true;
      };
    };
    home.activation.setupEtc = config.lib.dag.entryAfter [ "writeBoundary" ] ''
      /run/current-system/sw/bin/systemctl start --user sops-nix
    '';
  };
}
