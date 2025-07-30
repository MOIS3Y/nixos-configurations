# █░█ █▀ █▀▀ █▀█ █▀ ▀
# █▄█ ▄█ ██▄ █▀▄ ▄█ ▄
# -- -- -- -- -- -- -

{ lib, ... }: let
  inherit (lib)
    mkOption
    types
    literalExpression;
in {
  options.host.users = mkOption {
      type = types.listOf (types.enum [ "stepan" ]);
      default = [ "stepan" ];
      description = "List of preconfigured users";
      example = literalExpression ''
        host.users = [ "stepan" ];
      '';
    };
  config = {};
}
