# █▀ █▀ █░█ ▀
# ▄█ ▄█ █▀█ ▄
# -- -- -- --

{ config, lib, ... }: let
  cfg = config.programs.ssh;
  inherit (lib)
    mkOption
    types
    attrsets;
in {
  options.programs.ssh = {
    userMatchBlocks = mkOption {
      type = types.enum [
        "stepan"
        "admserv"
        "nix-on-droid"
        "empty"  # ? if user doesn't use matchBlocks
      ];
      default = "empty";
      description = "Pre-configured user-specific matchBlocks";
    };
  };
  config = {
    programs.ssh = {
      enable = true;
      extraOptionOverrides = {
        AddKeysToAgent = "yes";
      };
      enableDefaultConfig = false;  #? default values will be removed in the future
      matchBlocks = attrsets.attrByPath [ cfg.userMatchBlocks ] "empty" (
        import ./matchers.nix { inherit config; }
      ); # empty is a default value {} to return if the path does not exist in attrset;
    };
  };
}
