# █▀▄ █▀▀ █▀ █▄▀ ▀█▀ █▀█ █▀█ ▀
# █▄▀ ██▄ ▄█ █░█ ░█░ █▄█ █▀▀ ▄
# -- -- -- -- -- -- -- -- -- -

# The module sets values ​​for config.desktop.
# These values ​​are available across both NixOS and HM configurations.
# Options can be overridden or expanded later in the configuration 
# itself individually for each host.
# For example, the desktop.games option has additional options in _shared.

{ config, pkgs, lib, host, ... }: {
  imports = [
    ./module.nix
  ];
  desktop = with lib; {
    enable = host.desktop.enable;
    laptop.enable = host.desktop.laptop.enable;
    xorg.enable = host.desktop.xorg.enable;
    wayland.enable = host.desktop.wayland.enable;
    games.enable = host.desktop.games.enable;
    devices = {
      monitors = attrsets.attrByPath [ "monitors" ] "monitors" host.desktop.devices;
      keyboard = attrsets.attrByPath [ "keyboard" ] "keyboard" host.desktop.devices;
    };
  };
}
