# █░█ █▀ █▀▀ █▀█ █▀ ▀
# █▄█ ▄█ ██▄ █▀▄ ▄█ ▄
# -- -- -- -- -- -- -

{ config, pkgs, lib, ... }: let
  cfg = config.host;
  inherit (lib)
    mkOption
    attrsets
    types
    literalExpression;
in {
  options.host = {
    users = mkOption {
      type = types.listOf (types.enum [ "stepan" "admserv" ]);
      default = [ "stepan" ];
      description = "List of preconfigured users";
      example = literalExpression ''
        host.users = [ "stepan" "admserv" ];
      '';
    };
  };
  config = {
    users = {
      users = attrsets.getAttrs config.host.users (
        import ./users.nix { inherit config pkgs;}
      );
    };
  };
}
