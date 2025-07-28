# █▀▄ █▀▀ █▀█ █▄░█ █▀▀ ▀
# █▄▀ █▄▄ █▄█ █░▀█ █▀░ ▄
# -- -- -- -- -- -- -- -- --

{ config, ... }: let
  inherit (config.colorScheme)
    variant;
  in{
  dconf.settings = {
    "org/virt-manager/virt-manager/connections" = {
      autoconnect = ["qemu:///system"];
      uris = ["qemu:///system"];
    };
    "org/gnome/desktop/interface" = {
      color-scheme = ''${
        if variant == "dark" then "prefer-dark" else "default"
      }'';
    };
    "org/gnome/desktop/wm/preferences" = {
      button-layout = "appmenu:close";
    };
  };
}
