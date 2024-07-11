# █░█░█ ▄▀█ █▄█ █▄▄ ▄▀█ █▀█ ▀
# ▀▄▀▄▀ █▀█ ░█░ █▄█ █▀█ █▀▄ ▄
# -- -- -- -- -- -- -- -- -- 

{ config, pkgs, utils, ... }: with utils; {
  launcher-toggle = pkgs.writeShellScript "waybar-launcher-toggle.sh" ''
    # TODO: automatic launcher detection
    ${pgrep} wofi >/dev/null 2>&1 && ${pkill} wofi || ${wofi} --show drun
  '';
  hyprctl-swallow = pkgs.writeShellScript "waybar-hyprctl-swallow.sh" ''
    if ${hyprctl} getoption misc:enable_swallow | ${rg} -q "int: 1"; then
      ${hyprctl} keyword misc:enable_swallow false >/dev/null &&
        ${notify-send} -a Hyprland -i display -t 1500 "Turned off swallowing"
    else
      ${hyprctl} keyword misc:enable_swallow true >/dev/null &&
        ${notify-send} -a Hyprland -i display -t 1500 "Turned on swallowing"
    fi
  '';
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
  switch-workspaces-to-right = "${hyprctl} dispatch workspace e+1";
  switch-workspaces-to-left = "${hyprctl} dispatch workspace e-1";
  calc = "${gnome-calculator}";
  logout = "${wlogout}";
  notification-get = "${swaync-client} -swb";
  notification-dnd = "${swaync-client} -d -sw";
  notification-center = "${swaync-client} -t -sw";
  brightness-up = "${brightnessctl} s +1%";
  brightness-down = "${brightnessctl} s 1%-";
  volume-mute = "${volumectl} toggle-mute";
  mic-mute = "${volumectl} -m toggle-mute";
  mic-up = "${pamixer} --default-source -i 1";
  mic-down = "${pamixer} --default-source -d 1";
}
