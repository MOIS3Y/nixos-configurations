# █▀ █▀█ █▀█ █▀ ▀
# ▄█ █▄█ █▀▀ ▄█ ▄
# -- -- -- -- -- 

{ inputs, config, lib, ... }: let
  inherit (lib)
    mkOption
    types
    attrsets;
in {
  imports = [
    inputs.sops-nix.homeManagerModules.sops
  ];
  options.sops = {
    defaultUserSopsFile = mkOption {
      type = types.path;
      example = secrets/secrets.yaml;
      description = "path to the file with secrets";
    };
    sharedSecrets = mkOption {
      type = types.enum [
        "stepan"
        # add more enum value here ...
      ];
      description = "Preconfigured secrets that can be imported";
    };
  };
  config = {
    sops = {
      defaultSopsFile = config.sops.defaultUserSopsFile;
      age = {
        keyFile = "${config.xdg.configHome}/sops/age/keys.txt";
        generateKey = true;
      };
      secrets = attrsets.attrByPath [ config.sops.sharedSecrets ] "stepan" (
        import ./secrets.nix { inherit config;}
      ); # stepan is a default value to return if the path does not exist in attrset
    };
    home.activation.setupEtc = config.lib.dag.entryAfter [ "writeBoundary" ] ''
      /run/current-system/sw/bin/systemctl start --user sops-nix
    '';
  };
}
