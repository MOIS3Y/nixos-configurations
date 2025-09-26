# █▀ █░█░█ ▄▀█ █▄█ █▄░█ █▀▀ ▀
# ▄█ ▀▄▀▄▀ █▀█ ░█░ █░▀█ █▄▄ ▄
# -- -- -- -- -- -- -- -- -- 

{config, pkgs, ... }: let
  inherit (config.desktop.utils)
    cat
    curl
    cut
    gnome-calculator
    grim
    hyprctl
    jq
    ddcutil
    notify-send
    pamixer
    rfkill
    rg
    rm
    slurp
    systemctl
    swappy
    wayland-logout
    zenity;
in {
  desktop.scripts.swaync = {
    # toggles:
    hyprctl-swallow = pkgs.writeShellScript "swaync-hyprctl-swallow.sh" ''
      check_status() {
        if ${hyprctl} getoption misc:enable_swallow | ${rg} -q "int: 1"; then
          echo "true"
        else
          echo "false"
        fi
      }

      toggle_swallow() {
        echo "toggle" > /tmp/waybar-swallow-rx  #? see: hyprctl-swallow
      }

      main() {
        case "$1" in
          --toggle | -t)
            toggle_swallow
            ;;
          --status | -s)
            check_status
            ;;
          *)
            check_status
            ;;
        esac
      }

      # Run it:
      main "$@"
    '';
    hyprctl-hyprsunset = pkgs.writeShellScript "swaync-hyprctl-hyprsunset.sh" ''
      #? see: https://github.com/hyprwm/hyprsunset/issues/51
      #? see: https://github.com/hyprwm/hyprsunset/issues/26
      NIGHT_TEMP="5000"
      DAY_TEMP="6650"  #? eq identity value (issues above)

      get_current_temp() {
        ${hyprctl} hyprsunset temperature
      }

      toggle_temperature() {
        echo "toggle" > /tmp/waybar-hyprsunset-rx  #? see: hyprctl-hyprsunset
      }

      check_temperature() {
        current_temp=$(get_current_temp)
        if [ "$current_temp" == "$DAY_TEMP" ]; then
          echo "false"
        else
          echo "true"
        fi
      }

      main() {
        case "$1" in
          --toggle | -t)
              toggle_temperature
              ;;
          --identity | -i)
              check_temperature
              ;;
          *)
              get_current_temp
              ;;
        esac
      }

      # Run it:
      main "$@"
    '';
    airplane-mode = pkgs.writeShellScript "swaync-airplane-mode.sh" ''
      check_status() {
        if ${rfkill} list wifi | ${rg} -q "Soft blocked: yes|Hard blocked: yes"; then
          echo "true"
        else
          echo "false"
        fi
      }

      toggle_airplane_mode() {
        local current_status
        current_status=$(check_status)

        if [[ "$current_status" == "true" ]]; then
          ${rfkill} unblock wifi
        else
          ${rfkill} block wifi
        fi
      }

      main() {
        case "$1" in
          --toggle | -t)
              toggle_airplane_mode
              ;;
          --status | -s)
              check_status
              ;;
          *)
              check_status
              ;;
        esac
      }

      # Run it:
      main "$@"
    '';
    # power management:
    power-management = pkgs.writeShellScript "swaync-power-management.sh" ''
      # Configuration
      TIMEOUT=10
      APP_NAME="Power Management"

      # Commands
      LOGOUT_CMD="${wayland-logout}"
      SUSPEND_CMD="${systemctl} suspend"
      HIBERNATE_CMD="${systemctl} hibernate"
      REBOOT_CMD="${systemctl} reboot"
      SHUTDOWN_CMD="${systemctl} poweroff"

      # Icons for different actions
      LOGOUT_ICON="system-log-out"
      SUSPEND_ICON="system-suspend"
      HIBERNATE_ICON="system-hibernate"
      REBOOT_ICON="system-reboot"
      SHUTDOWN_ICON="system-shutdown"

      # Show confirmation dialog
      show_confirmation() {
        local action=$1
        local icon=$2

        ${zenity} --question \
          --title="$APP_NAME" \
          --icon="$icon" \
          --text="Are you sure you want to $action the system?" \
          --ok-label="Confirm" \
          --cancel-label="Cancel" \
          --width=380 \
          --height=130 \
          --timeout=$TIMEOUT
        return $?
      }

      # Send notification
      send_notification() {
        local title=$1
        local message=$2
        local icon=$3
        local timeout_ms=$((TIMEOUT * 1000))

        ${notify-send} \
          --expire-time="$timeout_ms" \
          -a "$APP_NAME" \
          -i "$icon" "$title" "$message" 2>/dev/null || true
      }

      # Send cancellation notification
      send_cancellation() {
        local action=$1
        local icon=$2

        send_notification "$APP_NAME" "$action operation was cancelled" "$icon"
      }

      main() {
        case "$1" in
          --logout)
              if show_confirmation "logout" "$LOGOUT_ICON"; then
                $LOGOUT_CMD
              else
                send_cancellation "Logout" "$LOGOUT_ICON"
              fi
              ;;
          --suspend)
              if show_confirmation "suspend" "$SUSPEND_ICON"; then
                $SUSPEND_CMD
              else
                send_cancellation "Suspend" "$SUSPEND_ICON"
              fi
              ;;
          --shutdown)
              if show_confirmation "shutdown" "$SHUTDOWN_ICON"; then
                $SHUTDOWN_CMD
              else
                send_cancellation "Shutdown" "$SHUTDOWN_ICON"
              fi
              ;;
          --reboot)
              if show_confirmation "reboot" "$REBOOT_ICON"; then
                $REBOOT_CMD
              else
                send_cancellation "Reboot" "$REBOOT_ICON"
              fi
              ;;
          --hibernate)
              if show_confirmation "hibernate" "$HIBERNATE_ICON"; then
                $HIBERNATE_CMD
              else
                send_cancellation "Hibernate" "$HIBERNATE_ICON"
              fi
              ;;
          --help|-h)
              echo "Usage: $0 [--shutdown|--reboot|--hibernate|--suspend|--help]"
              echo ""
              echo "Commands used:"
              echo "  Shutdown:  $SHUTDOWN_CMD"
              echo "  Reboot:    $REBOOT_CMD"
              echo "  Hibernate: $HIBERNATE_CMD"
              echo "  Suspend:   $SUSPEND_CMD"
              echo ""
              echo "Icons used:"
              echo "  Shutdown:  $SHUTDOWN_ICON"
              echo "  Reboot:    $REBOOT_ICON"
              echo "  Hibernate: $HIBERNATE_ICON"
              echo "  Hibernate: $SUSPEND_ICON"
              ;;
          *)
              echo "Error: No action specified"
              echo "Use --help for usage information"
              exit 1
              ;;
        esac
      }

      # Run main function with all arguments
      main "$@"
    '';
    # fans:
    coolercontrol = pkgs.writeShellScript "swaync-coolercontrol.sh" ''
      USERNAME=$(${cat} ${config.sops.secrets."coolercontrol/username".path})
      PASSWORD=$(${cat} ${config.sops.secrets."coolercontrol/password".path})
      
      DAEMON_ADDRESS="http://localhost:11987"

      SILENT_MODE_NAME="Silent"
      AUTO_MODE_NAME="Auto"

      COOKIE_FILE="/tmp/cc_cookie.txt"

      # Login function
      login() {
        ${curl} -s \
          -u "$USERNAME:$PASSWORD" \
          -c "$COOKIE_FILE" \
          -X POST "$DAEMON_ADDRESS/login" > /dev/null
      }

      # Get current mode status
      get_status() {
        login
        current_mode=$(
          ${curl} -s \
            -b "$COOKIE_FILE" "$DAEMON_ADDRESS/modes-active" | \
            ${jq} -r '.current_mode_uid'
        )
        
        # Get Silent mode UID
        silent_uid=$(
          ${curl} -s \
            -b "$COOKIE_FILE" "$DAEMON_ADDRESS/modes" | \
            ${jq} -r --arg name "$SILENT_MODE_NAME" '.modes[] | select(.name == $name) | .uid'
        )
        
        if [ "$current_mode" = "$silent_uid" ]; then
            echo "true"
        else
            echo "false"
        fi
      }

      # Toggle mode
      toggle_mode() {
        login
        current_status=$(get_status)
        
        # Get mode UIDs
        modes=$(${curl} -s -b "$COOKIE_FILE" "$DAEMON_ADDRESS/modes")
        silent_uid=$(
          echo "$modes" | \
            ${jq} -r --arg name "$SILENT_MODE_NAME" '.modes[] | select(.name == $name) | .uid'
        )
        auto_uid=$(
          echo "$modes" | \
            ${jq} -r --arg name "$AUTO_MODE_NAME" '.modes[] | select(.name == $name) | .uid'
        )
        
        if [ "$current_status" = "true" ]; then
          # Switch to Auto
          target_uid="$auto_uid"
          target_name="$AUTO_MODE_NAME"
        else
          # Switch to Silent
          target_uid="$silent_uid"
          target_name="$SILENT_MODE_NAME"
        fi
        
        # Activate mode
        response=$(
          ${curl} -s \
            -w "%{http_code}" \
            -b "$COOKIE_FILE" \
            -X POST "$DAEMON_ADDRESS/modes-active/$target_uid"
        )
        http_code="''${response: -3}"
        
        if [ "$http_code" -eq 200 ]; then
          echo "Switched to $target_name mode"
        else
          echo "Error: Failed to switch to $target_name mode"
          exit 1
        fi
      }

      # Cleanup
      cleanup() {
        ${rm} -f "$COOKIE_FILE"
      }

      # Main function
      main() {
        local option="$1"
        
        case "$option" in
          -t|--toggle)
              toggle_mode
              ;;
          -s|--status)
              get_status
              ;;
          "")
              echo "Usage: $0 [--toggle|-t] [--status|-s]"
              echo "  --toggle, -t    Switch between $SILENT_MODE_NAME and $AUTO_MODE_NAME modes"
              echo "  --status, -s    Check if $SILENT_MODE_NAME mode is active (returns true/false)"
              exit 1
              ;;
          *)
              echo "Error: Unknown option '$option'"
              echo "Usage: $0 [--toggle|-t] [--status|-s]"
              exit 1
              ;;
        esac
      }

      # Set trap and call main function
      trap cleanup EXIT
      main "$@"
    '';
    # sliders:
    mic-getter =  "${pamixer} --default-source --get-volume";
    mic-setter = "${pamixer} --default-source --set-volume $value";
    ddcutil-getter = "${ddcutil} -t getvcp 10 | ${cut} -d ' ' -f 4";
    ddcutil-setter = "echo $value > /tmp/waybar-ddc-module-rx";  #? see: ddcutil-fast"  
    # apps:
    calc = "${gnome-calculator}";
    screenshot = pkgs.writeShellScript "swaync-screenshot.sh" ''
      ${grim} -g "$(${slurp} -w 0)" - | ${swappy} -f -
    '';
  };
}
