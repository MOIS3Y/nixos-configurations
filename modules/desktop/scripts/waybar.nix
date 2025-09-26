# █░█░█ ▄▀█ █▄█ █▄▄ ▄▀█ █▀█ ▀
# ▀▄▀▄▀ █▀█ ░█░ █▄█ █▀█ █▀▄ ▄
# -- -- -- -- -- -- -- -- -- 

{ config, pkgs, ... }: let
  inherit (config.desktop.utils)
    btm
    brightnessctl
    ddcutil
    gnome-calendar
    gnome-calculator
    gnome-disks
    gnome-system-monitor
    htop
    hyprctl
    mkfifo
    pamixer
    paplay
    pavucontrol
    pgrep
    pkill
    rg
    rm
    swaync-client
    volumectl
    wlogout;
  inherit (config.desktop.apps)
    launcher
    terminal;
  inherit (config.desktop.assets.sounds)
    toggle-beep;
  inherit (config.desktop)
    devices;
  # inherit (config.programs)
  #   waybar;
  in {
  desktop.scripts.waybar = {
    # Toggle scripts:
    launcher-toggle = pkgs.writeShellScript "waybar-launcher-toggle.sh" ''
      if ${pgrep} -f "${launcher}" > /dev/null 2>&1; then
        ${pkill} -f "${launcher}"
      else
        ${launcher}
      fi
    '';
    btm-toggle = pkgs.writeShellScript "waybar-btm-toggle.sh" ''
      ${pgrep} btm >/dev/null 2>&1 && ${pkill} btm || ${terminal} -e ${btm}
    '';
    htop-toggle = pkgs.writeShellScript "waybar-htop-toggle.sh" ''
      ${pgrep} htop >/dev/null 2>&1 && ${pkill} htop || ${terminal} -e ${htop}
    '';
    gnome-calendar-toggle = pkgs.writeShellScript "waybar-gnome-calendar-toggle.sh" ''
      ${pgrep} gnome-calendar >/dev/null 2>&1 && ${pkill} gnome-calendar || ${gnome-calendar}
    '';
    gnome-disks-toggle = pkgs.writeShellScript "waybar-gnome-disks-toggle.sh" ''
      ${pgrep} gnome-disks >/dev/null 2>&1 && ${pkill} gnome-disks || ${gnome-disks}
    '';
    gnome-system-monitor-toggle = pkgs.writeShellScript "waybar-gnome-system-monitor-toggle.sh" ''
      if ${pgrep} -f "${gnome-system-monitor}" > /dev/null 2>&1; then
        ${pkill} -f "${gnome-system-monitor}"
      else
        ${gnome-system-monitor}
      fi
    '';
    pavucontrol-toggle = pkgs.writeShellScript "waybar-pavucontrol-toggle.sh" ''
      ${pgrep} pavucontrol >/dev/null 2>&1 && ${pkill} pavucontrol || ${pavucontrol}
    '';
    # hyprland specific:
    hyprctl-swallow = pkgs.writeShellScript "waybar-hyprctl-swallow.sh" ''
      receive_pipe="/tmp/waybar-swallow-rx"

      setup_pipe() {
        ${rm} -rf "$receive_pipe"
        ${mkfifo} "$receive_pipe"
      }

      check_swallow_status() {
        if ${hyprctl} getoption misc:enable_swallow | ${rg} -q "int: 1"; then
          echo "enabled"
        else
          echo "disabled"
        fi
      }

      get_waybar_output() {
        local status
        status=$(check_swallow_status)
        
        case "$status" in
          enabled)
              echo '{"text": "󰊰", "tooltip": "Window swallow enabled", "class": "visible"}'
              ;;
          disabled)
              echo '{"text": "", "tooltip": "Window swallow disabled", "class": "hidden"}'
              ;;
          *)
              echo '{"text": "", "tooltip": "Unknown status", "class": "hidden"}'
              ;;
        esac
      }

      toggle_swallow() {
        local current_status
        current_status=$(check_swallow_status)
        
        case "$current_status" in
          enabled)
              ${hyprctl} keyword misc:enable_swallow false >/dev/null 2>&1
              ;;
          disabled)
              ${hyprctl} keyword misc:enable_swallow true >/dev/null 2>&1
              ;;
        esac
      }

      process_command() {
        local command="$1"
        
        case "$command" in
          toggle)
              toggle_swallow
              ;;
          status)
              # Just return status without changes
              ;;
          *)
              echo "Unknown command: $command" >&2
              return 1
              ;;
        esac
      }

      main_loop() {
        while true; do
          local command
          read -r command < "$receive_pipe"
          
          if process_command "$command"; then
              get_waybar_output
          fi
        done
      }

      cleanup() {
          {rm} -f "$receive_pipe"
          exit 0
      }

      main() {
        trap cleanup EXIT INT TERM
        setup_pipe
        get_waybar_output
        main_loop
      }

      # Run it:
      main "$@"
    '';
    hyprctl-swallow-toggle = pkgs.writeShellScript "waybar-hyprctl-swallow-toggle.sh" ''
      echo "toggle" > /tmp/waybar-swallow-rx
    '';
    hyprctl-swallow-status = pkgs.writeShellScript "waybar-hyprctl-swallow-status.sh" ''
      echo "status" > /tmp/waybar-swallow-rx
    '';
    hyprctl-hyprsunset = pkgs.writeShellScript "waybar-hyprctl-hyprsunset.sh" ''
      receive_pipe="/tmp/waybar-hyprsunset-rx"
      #? see: https://github.com/hyprwm/hyprsunset/issues/51
      #? see: https://github.com/hyprwm/hyprsunset/issues/26
      NIGHT_TEMP="5000"
      DAY_TEMP="6650"  #? eq identity value (issues above)

      setup_pipe() {
        ${rm} -rf "$receive_pipe"
        ${mkfifo} "$receive_pipe"
      }

      get_current_temp() {
        ${hyprctl} hyprsunset temperature 2>/dev/null
      }

      check_temperature_status() {
        local current_temp
        current_temp=$(get_current_temp)
        
        if [ "$current_temp" = "$DAY_TEMP" ]; then
          echo "day"
        else
          echo "night"
        fi
      }

      get_waybar_output() {
        local status
        status=$(check_temperature_status)
        
        case "$status" in
          day)
              echo '{"text": "", "tooltip": "Day mode", "class": "hidden"}'
              ;;
          night)
              echo '{"text": "󱩌", "tooltip": "Night mode active", "class": "visible"}'
              ;;
          *)
              echo '{"text": "", "tooltip": "Unknown status", "class": "hidden"}'
              ;;
        esac
      }

      toggle_temperature() {
        local current_temp
        current_temp=$(get_current_temp)
        
        if [ "$current_temp" = "$NIGHT_TEMP" ]; then
          ${hyprctl} hyprsunset temperature "$DAY_TEMP" >/dev/null 2>&1
        else
          ${hyprctl} hyprsunset temperature "$NIGHT_TEMP" >/dev/null 2>&1
        fi
      }

      process_command() {
        local command="$1"
        
        case "$command" in
          toggle)
              toggle_temperature
              ;;
          status)
              # Just return status without changes
              ;;
          *)
              echo "Unknown command: $command" >&2
              return 1
              ;;
        esac
      }

      main_loop() {
        while true; do
          local command
          read -r command < "$receive_pipe"
          
          if process_command "$command"; then
            get_waybar_output
          fi
        done
      }

      cleanup() {
        rm -f "$receive_pipe"
        exit 0
      }

      main() {
        trap cleanup EXIT INT TERM
        
        setup_pipe
        get_waybar_output
        main_loop
      }

      # Run it:
      main "$@"
    '';
    hyprctl-hyprsunset-toggle = pkgs.writeShellScript "waybar-hyprctl-hyprsunset-toggle.sh" ''
      echo "toggle" > /tmp/waybar-hyprsunset-rx
    '';
    hyprctl-hyprsunset-status = pkgs.writeShellScript "waybar-hyprctl-hyprsunset-status.sh" ''
      echo "status" > /tmp/waybar-hyprsunset-rx
    '';
    # External monitor managment:
    ddcutil-fast = pkgs.writeShellScript "waybar-ddcutil-fast.sh" ''
      # src: https://gist.github.com/Ar7eniyan/42567870ad2ce47143ffeb41754b4484

      receive_pipe="/tmp/waybar-ddc-module-rx"
      step=${builtins.toString devices.ddcci.step}

      ddcutil_fast() {
        # ! adjust the bus number and the multiplier for your display
        # ! multiplier should be chosen so that it both works reliably and fast enough
        ${ddcutil} \
        --noverify \
        --bus ${builtins.toString devices.ddcci.busNumber} \
        --sleep-multiplier .0${builtins.toString devices.ddcci.multiplier} "$@" 2>/dev/null
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

      ${rm} -rf $receive_pipe
      ${mkfifo} $receive_pipe

      # in case waybar restarted the script after restarting/replugging a monitor
      print_brightness ddcutil_slow

      while true; do
          read -r command < $receive_pipe
          case $command in
              + | -)
                  ddcutil_fast setvcp 10 $command $step
                  ;;
              max)
                  ddcutil_fast setvcp 10 ${builtins.toString devices.ddcci.bright} 
                  ;;
              min)
                  ddcutil_fast setvcp 10 ${builtins.toString devices.ddcci.dark}
                  ;;
              *)
                  # Check if the command is a number from 0 to 100 (for swaync slider)
                  if [[ $command =~ ^[0-9]+$ ]] && [ $command -ge 0 ] && [ $command -le 100 ]; then
                      ddcutil_fast setvcp 10 $command
                  else
                      echo "Unknown command: $command" >&2
                  fi
                  ;;
          esac
          print_brightness ddcutil_fast
      done
    '';
    ddcutil-up = pkgs.writeShellScript "waybar-ddcutil-up.sh" ''
      echo '+' > /tmp/waybar-ddc-module-rx
    '';
    ddcutil-down = pkgs.writeShellScript "waybar-ddcutil-down.sh" ''
      echo '-' > /tmp/waybar-ddc-module-rx
    '';
    ddcutil-bright = pkgs.writeShellScript "waybar-ddcutil-bright.sh" ''
      echo 'max' > /tmp/waybar-ddc-module-rx
    '';
    ddcutil-dark = pkgs.writeShellScript "waybar-ddcutil-dark.sh" ''
      echo 'min' > /tmp/waybar-ddc-module-rx
    '';
    # Common:
    switch-workspaces-to-right = "${hyprctl} dispatch workspace e+1";
    switch-workspaces-to-left = "${hyprctl} dispatch workspace e-1";
    switch-keyboard-layout = "${hyprctl} switchxkblayout ${devices.keyboard.settings.name} next";
    calc = "${gnome-calculator}";
    logout = "${wlogout}";
    notification-get = "${swaync-client} -swb";
    notification-dnd = "${swaync-client} -d & ${paplay} ${toggle-beep} &";
    notification-center = "${swaync-client} -t";
    brightness-up = "${brightnessctl} s +1%";
    brightness-down = "${brightnessctl} s 1%-";
    volume-mute = "${volumectl} toggle-mute & ${paplay} ${toggle-beep} &";
    mic-mute = "${volumectl} -m toggle-mute & ${paplay} ${toggle-beep} &";
    mic-up = "${pamixer} --default-source -i 1";
    mic-down = "${pamixer} --default-source -d 1";
  };
}