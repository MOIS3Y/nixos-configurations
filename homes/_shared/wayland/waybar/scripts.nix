# █▀ █▀▀ █▀█ █ █▀█ ▀█▀ █▀ ▀
# ▄█ █▄▄ █▀▄ █ █▀▀ ░█░ ▄█ ▄
# -- -- -- -- -- -- -- -- -

{ config, pkgs, lib, ... }:
  let
    # tools:
    browser = "${lib.getExe pkgs.firefox}";  #TODO: use from global conf
    calc = "${pkgs.gnome.gnome-calculator}/bin/gnome-calculator";
    brightnessctl = "${lib.getExe pkgs.brightnessctl}";
    pamixer = "${lib.getExe pkgs.pamixer}";
    hyprctl = "${pkgs.hyprland}/bin/hyprctl";
    nautilus = "${lib.getExe pkgs.gnome.nautilus}";  #TODO: use from global conf
    notify-send = "${lib.getExe pkgs.libnotify}";
    rg = "${lib.getExe pkgs.ripgrep}";
    terminal = "${lib.getExe pkgs.wezterm}";  #TODO: use from global conf
    wlogout = "${lib.getExe pkgs.wlogout}";
    volumectl = "${pkgs.avizo}/bin/volumectl";
    wofi = "${lib.getExe pkgs.wofi}";  #TODO: use from global conf
    # custom:
    wofi-toggle = with pkgs; writeShellScript "wofi-toggle" ''
      pgrep wofi >/dev/null 2>&1 && pkill wofi || ${wofi} --show drun
    '';
    file-manager-toggle = with pkgs; writeShellScript "file-manager-toggle" ''
      pgrep nautilus >/dev/null 2>&1 && pkill nautilus || ${nautilus}
    '';
    hyprctl-swallow = with pkgs; writeShellScript "waybar-swallow" ''
      if ${hyprctl} getoption misc:enable_swallow | ${rg} -q "int: 1"; then
        ${hyprctl} keyword misc:enable_swallow false >/dev/null &&
          ${notify-send} -a Hyprland -i display -t 1500 "Turned off swallowing"
      else
        ${hyprctl} keyword misc:enable_swallow true >/dev/null &&
          ${notify-send} -a Hyprland -i display -t 1500 "Turned on swallowing"
      fi
    '';
  in {
  # bin tools:
  #TODO: need replace code duplicates
  inherit browser;
  inherit calc;
  inherit file-manager-toggle;
  inherit brightnessctl;
  inherit nautilus;
  inherit pamixer;
  inherit hyprctl;
  inherit hyprctl-swallow;
  inherit terminal;
  inherit volumectl;
  inherit wlogout;
  inherit wofi-toggle;
}
