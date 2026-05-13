# █░█ █▀ █▀▀ █▀█ █▀ ▀
# █▄█ ▄█ ██▄ █▀▄ ▄█ ▄
# -- -- -- -- -- -- -
# Configures global users and their default groups.

{
  config,
  pkgs,
  lib,
  ...
}:
let
  allUsers = {
    stepan = {
      isNormalUser = true;
      description = "Stepan Zhukovsky";
      extraGroups = [
        "networkmanager"
        "wireshark"
        "wheel"
        "libvirtd"
        "input"
        "i2c"
      ];
      shell = pkgs.zsh;
    };
  };
in
{
  users.users = lib.attrsets.getAttrs config.host.users allUsers;
}
