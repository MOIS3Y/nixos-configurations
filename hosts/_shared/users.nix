# █░█ █▀ █▀▀ █▀█ █▀ ▀
# █▄█ ▄█ ██▄ █▀▄ ▄█ ▄
# -- -- -- -- -- -- -
# Configures global users and their default groups.

{ pkgs, ... }:
{
  users.users = {
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
  # add more users here ...
}
