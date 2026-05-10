# █▀▀ █▀█ █▀▀ █▀▀ ▀█▀ █▀▄ ▀
# █▄█ █▀▄ ██▄ ██▄ ░█░ █▄▀ ▄
# -- -- -- -- -- -- -- -- -

{
  config,
  pkgs,
  lib,
  ...
}:
let
  inherit (config.services)
    greetd
    displayManager
    ;
  inherit (config.colorScheme)
    palette
    ;
  inherit (config.desktop)
    assets
    cursor
    ;
in
{
  assertions = [
    {
      assertion = greetd.enable -> displayManager.enable;
      message = ''
        [Configuration Error]
        Display Manager must be enabled for session list functionality.
        greetd depends of session list

        Solution:
        1. Enable the display manager globally:
          `services.displayManager.enable = true;`

        2. Or enable it via the desktop module:
          `desktop.displayManager.enable = true;`

        Note: This ensures proper session data initialization.
      '';
    }
    {
      assertion = greetd.enable -> !displayManager.gdm.enable;
      message = ''
        [Conflict Detected] GDM and greetd are mutually exclusive!

        Resolution:
        • To use greetd, disable GDM:
          `services.displayManager.gdm.enable = false;`
          or via desktop module:
          `desktop.displayManager.gdm.enable = false;`

        • To use GDM, disable greetd:
          `services.greetd.enable = false;`
      '';
    }
  ];
  services.greetd = {
    enable = lib.mkDefault config.desktop.displayManager.greetd.enable;
    settings = {
      default_session = {
        user = "greeter";
        command = "${pkgs.writeShellScript "greetd-session" ''
          export XCURSOR_THEME=${config.desktop.cursor.name}
          export XCURSOR_SIZE=24

          ${lib.getExe pkgs.niri} --config ${pkgs.writeText "niri-greet-config.kdl" ''
            output "DP-1" {
                focus-at-startup
                layout { background-color "#${palette.base00}"; }
            }
            output "eDP-1" {
                focus-at-startup
                layout { background-color "#${palette.base00}"; }
            }
            output "HDMI-A-1" {
                focus-at-startup
                layout { background-color "#${palette.base00}"; }
            }

            hotkey-overlay {
                skip-at-startup
            }

            cursor {
                xcursor-theme "${cursor.name}"
                xcursor-size 24
            }

            // Hide the default Niri focus ring
            layout {
                focus-ring { off; }
            }

            // Force mdgreet to open in fullscreen
            window-rule {
                match at-startup=true
                open-fullscreen true
            }

            // Launch mdgreet and exit niri when it's done
            spawn-sh-at-startup "${lib.getExe pkgs.extra.mdgreet} --config ${
              (pkgs.formats.toml { }).generate "mdgreet.toml" {
                appearance = {
                  greeting = "NixOS";
                  font_family = "Ubuntu";
                  theme = {
                    mode = "dark";
                    name = "seed";
                    seed_color = "#${palette.base0D}";
                  };
                  background = {
                    color = "#${palette.base00}";
                    path = "${assets.images.background}";
                    blur = 8.0;
                  };
                };
              }
            }; ${lib.getExe pkgs.niri} msg action quit --skip-confirmation"
          ''}
        ''}";
      };
    };
  };
}
