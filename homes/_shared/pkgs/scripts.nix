# █▀ █▀▀ █▀█ █ █▀█ ▀█▀ █▀ ▀
# ▄█ █▄▄ █▀▄ █ █▀▀ ░█░ ▄█ ▄
# -- -- -- -- -- -- -- -- --
# Custom user scripts managed by Nix.

{
  pkgs,
  lib,
  osConfig,
  ...
}:
{
  home.packages =
    lib.optionals osConfig.host.hardware.coolercontrol.enable [
      (pkgs.writeShellScriptBin "cct" ''
        set -euo pipefail

        # Configuration
        ADDR="http://localhost:11987"
        # Credentials from Sops
        U_PATH="${osConfig.sops.secrets."coolercontrol/username".path}"
        P_PATH="${osConfig.sops.secrets."coolercontrol/password".path}"
        USER=$(cat "$U_PATH")
        PASS=$(cat "$P_PATH")

        SILENT_NAME="Silent"
        AUTO_NAME="Auto"
        COOKIE_FILE=$(mktemp /tmp/cc_cookie.XXXXXX)

        # Colors for feedback
        G="\033[0;32m"
        R="\033[0m"
        B="\033[1m"

        cleanup() { rm -f "$COOKIE_FILE"; }
        trap cleanup EXIT

        login() {
          ${pkgs.curl}/bin/curl -s -u "$USER:$PASS" -c "$COOKIE_FILE" \
            -X POST "$ADDR/login" > /dev/null
        }

        get_status() {
          login
          local current_mode=$(${pkgs.curl}/bin/curl -s -b "$COOKIE_FILE" \
            "$ADDR/modes-active" | ${pkgs.jq}/bin/jq -r '.current_mode_uid')

          local silent_uid=$(${pkgs.curl}/bin/curl -s -b "$COOKIE_FILE" \
            "$ADDR/modes" | ${pkgs.jq}/bin/jq -r --arg n "$SILENT_NAME" \
            '.modes[] | select(.name == $n) | .uid')

          if [ "$current_mode" = "$silent_uid" ]; then
            echo "true"
          else
            echo "false"
          fi
        }

        toggle_mode() {
          login
          local current_status=$(get_status)
          local modes=$(${pkgs.curl}/bin/curl -s -b "$COOKIE_FILE" "$ADDR/modes")

          local s_uid=$(echo "$modes" | ${pkgs.jq}/bin/jq -r \
            --arg n "$SILENT_NAME" '.modes[] | select(.name == $n) | .uid')
          local a_uid=$(echo "$modes" | ${pkgs.jq}/bin/jq -r \
            --arg n "$AUTO_NAME" '.modes[] | select(.name == $n) | .uid')

          local target_uid=""
          local target_name=""

          if [ "$current_status" = "true" ]; then
            target_uid="$a_uid"
            target_name="$AUTO_NAME"
          else
            target_uid="$s_uid"
            target_name="$SILENT_NAME"
          fi

          local res=$(${pkgs.curl}/bin/curl -s -w "%{http_code}" \
            -b "$COOKIE_FILE" -X POST "$ADDR/modes-active/$target_uid")
          local http_code="''${res: -3}"

          if [ "$http_code" -eq 200 ]; then
            echo -e "''${B}CoolerControl:''${R} Switched to ''${G}$target_name''${R}"
          else
            echo "Error: Failed to switch to $target_name mode" >&2
            exit 1
          fi
        }

        case "''${1:-}" in
          -t|--toggle) toggle_mode ;;
          -s|--status) get_status ;;
          *)
            echo "Usage: cct [--toggle|-t] [--status|-s]"
            echo "  --toggle, -t    Switch between $SILENT_NAME and $AUTO_NAME"
            echo "  --status, -s    Check if $SILENT_NAME is active"
            exit 1
            ;;
        esac
      '')
    ]
    ++ [
      # Add new custom scripts here...
    ];
}
