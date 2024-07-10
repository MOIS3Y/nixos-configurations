# █▀ █▀▀ █▀█ █ █▀█ ▀█▀ █▀ ▀
# ▄█ █▄▄ █▀▄ █ █▀▀ ░█░ ▄█ ▄
# -- -- -- -- -- -- -- -- -

{ config, pkgs, lib, ... }:
  let
    # tools:
    browser = "${lib.getExe pkgs.firefox}";  #TODO: use from global conf
    calc = "${pkgs.gnome-calculator}/bin/gnome-calculator";
    brightnessctl = "${lib.getExe pkgs.brightnessctl}";
    ddcutil = "${lib.getExe pkgs.ddcutil}";
    pamixer = "${lib.getExe pkgs.pamixer}";
    hyprctl = "${pkgs.hyprland}/bin/hyprctl";
    nautilus = "${lib.getExe pkgs.nautilus}";  #TODO: use from global conf
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
    hyprctl-swallow = with pkgs; writeShellScript "hyprctl-swallow" ''
      if ${hyprctl} getoption misc:enable_swallow | ${rg} -q "int: 1"; then
        ${hyprctl} keyword misc:enable_swallow false >/dev/null &&
          ${notify-send} -a Hyprland -i display -t 1500 "Turned off swallowing"
      else
        ${hyprctl} keyword misc:enable_swallow true >/dev/null &&
          ${notify-send} -a Hyprland -i display -t 1500 "Turned on swallowing"
      fi
    '';
    ddcutil-fast =  with pkgs; with config.programs; writeShellScript "ddcutil-fast" ''
      # src: https://gist.github.com/Ar7eniyan/42567870ad2ce47143ffeb41754b4484

      receive_pipe="/tmp/waybar-ddc-module-rx"
      step=${builtins.toString waybar.ddcutil.step}

      ddcutil_fast() {
        # ! adjust the bus number and the multiplier for your display
        # ! multiplier should be chosen so that it both works reliably and fast enough
        ${ddcutil} \
        --noverify \
        --bus ${builtins.toString waybar.ddcutil.busNumber} \
        --sleep-multiplier .0${builtins.toString waybar.ddcutil.multiplier} "$@" 2>/dev/null
      }

      ddcutil_slow() {
        ${ddcutil} --maxtries 15,15,15 "$@" 2>/dev/null
      }

      # takes ddcutil commandline as arguments
      print_brightness() {
          if brightness=$("$@" -t getvcp 10); then
            brightness=$(echo "$brightness" | cut -d ' ' -f 4)
          else
            brightness=-1
          fi
          echo '{ "percentage":' "$brightness" '}'
      }

      rm -rf $receive_pipe
      mkfifo $receive_pipe

      # in case waybar restarted the script after restarting/replugging a monitor
      print_brightness ddcutil_slow

      while true; do
          read -r command < $receive_pipe
          case $command in
              + | -)
                  ddcutil_fast setvcp 10 $command $step
                  ;;
              max)
                  ddcutil_fast setvcp 10 ${builtins.toString waybar.ddcutil.bright} 
                  ;;
              min)
                  ddcutil_fast setvcp 10 ${builtins.toString waybar.ddcutil.dark}
                  ;;
          esac
          print_brightness ddcutil_fast
      done
    '';
    ddcutil-up = with pkgs; writeShellScript "ddcutil-up" ''
      echo '+' > /tmp/waybar-ddc-module-rx
    '';
    ddcutil-down = with pkgs; writeShellScript "ddcutil-down" ''
      echo '-' > /tmp/waybar-ddc-module-rx
    '';
    ddcutil-bright = with pkgs; writeShellScript "ddcutil-bright" ''
      echo 'max' > /tmp/waybar-ddc-module-rx
    '';
    ddcutil-dark = with pkgs; writeShellScript "ddcutil-dark" ''
      echo 'min' > /tmp/waybar-ddc-module-rx
    '';
  in {
  # bin tools:
  inherit 
  browser
  calc
  ddcutil-fast
  ddcutil-up
  ddcutil-down
  ddcutil-bright
  ddcutil-dark
  file-manager-toggle
  brightnessctl
  nautilus
  pamixer
  hyprctl
  hyprctl-swallow
  terminal
  volumectl
  wlogout
  wofi-toggle;
}
