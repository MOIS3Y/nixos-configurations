# █▄▄ ▄▀█ █▀█ █▀ ▀
# █▄█ █▀█ █▀▄ ▄█ ▄
# -- -- -- -- -- -

{ config, pkgs, lib, ... }:
  let
    widgets = import ./widgets.nix { inherit config; inherit pkgs; inherit lib;};
  in {
  primary = {
    layer = "top";
    position = "top";
    # mode = "dock";
    exclusive = true;
    passthrough = false;
    fixed-center = true;
    gtk-layer-shell = true;
    height = 39;
    modules-left = [
      "group/group-apps"
      "hyprland/workspaces"
    ];
    modules-center = [
      "custom/notification"
      "clock"
      "idle_inhibitor"
    ];
    modules-right = (lib.lists.subtractLists config.programs.waybar.excludeWidgets [
      "cpu"
      "memory"
      "group/group-disks"
      "group/group-audio"
      "pulseaudio#microphone"
      "group/group-backlight"
      "custom/ddcutil"
      "hyprland/language"
      "tray"
      "battery"
      "privacy"
      "custom/power"
    ]);
  } // (builtins.removeAttrs widgets config.programs.waybar.excludeWidgets);
}
