# █░█ █▀ █▀▀ █▀█ █▀ ▀
# █▄█ ▄█ ██▄ █▀▄ ▄█ ▄
# -- -- -- -- -- -- -

{ config, pkgs, lib, ... }: let
  cfg = config.host;
in {
  options.host = with lib; {
    users = mkOption {
      type = with types; listOf (enum [ "stepan" "admserv" ]);
      default = [ "stepan" ];
      description = "List of preconfigured users";
      example = literalExpression ''
        host.users = [ "stepan" "admserv" ];
      '';
    };
  };
  config = with lib; {
    users = {
      mutableUsers = false;
      users = attrsets.getAttrs config.host.users (
        import ./users.nix { inherit config pkgs;}
      );
    };
  };
}
