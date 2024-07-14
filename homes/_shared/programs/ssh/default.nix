# █▀ █▀ █░█ ▀
# ▄█ ▄█ █▀█ ▄
# -- -- -- --

{ config, pkgs, lib, ... }: let
  cfg = config.programs.ssh;
in {
  options.programs.ssh = with lib; {
    userMatchBlocks = mkOption {
      type = types.enum [
        "stepan"
        "admserv"
        "empty"  # ? if user doesn't use matchBlocks
      ];
      default = "empty";
      description = "Pre-configured user-specific matchBlocks";
    };
  };
  config = with lib; {
    programs.ssh = {
      enable = true;
      extraOptionOverrides = {
        AddKeysToAgent = "yes";
      };
      matchBlocks = attrsets.attrByPath [ cfg.userMatchBlocks ] "empty" (
        import ./matchers.nix { inherit config; }
      ); # empty is a default value {} to return if the path does not exist in attrset;
    };
  };
}
