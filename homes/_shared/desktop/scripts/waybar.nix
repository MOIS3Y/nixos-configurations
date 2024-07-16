# █░█░█ ▄▀█ █▄█ █▄▄ ▄▀█ █▀█ ▀
# ▀▄▀▄▀ █▀█ ░█░ █▄█ █▀█ █▀▄ ▄
# -- -- -- -- -- -- -- -- -- 

{ config, pkgs, ... }:
  with config.desktop.utils;
  with config.desktop.apps;
  with config.desktop.assets.sounds; {
  # Toggle scripts:
  launcher-toggle = pkgs.writeShellScript "waybar-launcher-toggle.sh" ''
    if ${pgrep} -f "${config.desktop.apps.launcher}" > /dev/null 2>&1; then
      ${pkill} -f "${config.desktop.apps.launcher}"
    else
      ${config.desktop.apps.launcher}
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
  hyprctl-swallow = pkgs.writeShellScript "waybar-hyprctl-swallow.sh" ''
    if ${hyprctl} getoption misc:enable_swallow | ${rg} -q "int: 1"; then
      ${hyprctl} keyword misc:enable_swallow false >/dev/null &&
        ${paplay} ${toggle-beep} &
        ${notify-send} -a Hyprland -i display -t 1500 "Turned off swallowing"
    else
      ${hyprctl} keyword misc:enable_swallow true >/dev/null &&
        ${paplay} ${toggle-beep} &
        ${notify-send} -a Hyprland -i display -t 1500 "Turned on swallowing"
    fi
  '';
  # External monitor managment:
  ddcutil-fast =  with config.programs; pkgs.writeShellScript "waybar-ddcutil-fast.sh" ''
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
  calc = "${gnome-calculator}";
  logout = "${wlogout}";
  notification-get = "${swaync-client} -swb";
  notification-dnd = "${swaync-client} -d -sw & ${paplay} ${toggle-beep} &";
  notification-center = "${swaync-client} -t -sw";
  brightness-up = "${brightnessctl} s +1%";
  brightness-down = "${brightnessctl} s 1%-";
  volume-mute = "${volumectl} toggle-mute & ${paplay} ${toggle-beep} &";
  mic-mute = "${volumectl} -m toggle-mute & ${paplay} ${toggle-beep} &";
  mic-up = "${pamixer} --default-source -i 1";
  mic-down = "${pamixer} --default-source -d 1";
}
