# █▀ █▀▀ █▀█ █░█ █ █▀▀ █▀▀ █▀ ▀
# ▄█ ██▄ █▀▄ ▀▄▀ █ █▄▄ ██▄ ▄█ ▄
# -- -- -- -- -- -- -- -- -- --
# Aggregates system services like display managers, audio, printing
# and background daemons.

{
  config,
  pkgs,
  lib,
  ...
}:
let
  cfg = config.desktop;
  inherit (config.services) greetd displayManager;
  inherit (config.matugen) mode;
  inherit (config.desktop) cursor;
  palette = config.matugen.theme.custom.palette.${mode};
in
{
  assertions = [
    {
      assertion = config.desktop.desktopManager.gnome.enable -> (cfg.compositors == [ ]);
      message = ''
        [Conflict Detected] GNOME and standalone compositors are mutually exclusive!

        Current state:
        • GNOME: enabled
        • Compositors: [ ${lib.concatStringsSep ", " cfg.compositors} ]

        Resolution:
        • To use GNOME, remove all entries from `desktop.compositors`.
        • To use standalone compositors, disable GNOME:
          `desktop.desktopManager.gnome.enable = false;`
      '';
    }
    {
      assertion = config.services.displayManager.enable -> config.desktop.enable;
      message = ''
        [Configuration Error] Incomplete desktop configuration detected!

        Problem:
        - Display Manager enabled (services.displayManager.enable = true)
        - But Desktop environment disabled (desktop.enable = false)

        Required Action:
        1. Recommended: Enable full desktop environment
          `desktop.enable = true;`

        2. Advanced: If you need minimal setup without desktop services:
          `services.displayManager.enable = false;`
      '';
    }
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

  services = {
    desktopManager = {
      gnome = {
        enable = lib.mkDefault config.desktop.desktopManager.gnome.enable;
      };
    };

    displayManager = {
      enable = cfg.displayManager.enable;
      gdm = {
        enable = cfg.displayManager.gdm.enable;
      };
    };

    dleyna = {
      enable = lib.mkDefault config.desktop.enable;
    };

    fstrim = {
      enable = true;
    };

    geoclue2 = {
      enable = lib.mkDefault config.desktop.enable;
      enableDemoAgent = lib.mkDefault false;
    };

    gnome = {
      at-spi2-core = {
        enable = lib.mkDefault config.desktop.enable;
      };
      sushi = {
        enable = lib.mkDefault config.desktop.enable;
      };
      gnome-keyring = {
        enable = lib.mkDefault config.desktop.enable;
      };
      evolution-data-server = {
        enable = lib.mkDefault config.desktop.enable;
      };
      gnome-online-accounts = {
        enable = lib.mkDefault config.desktop.enable;
      };
      localsearch = {
        enable = lib.mkDefault config.desktop.enable;
      };
    };

    greetd = {
      enable = lib.mkDefault config.desktop.displayManager.greetd.enable;
      settings = {
        default_session = {
          user = "greeter";
          command = "${pkgs.writeShellScript "greetd-session" ''
            export XCURSOR_THEME=${cursor.name}
            export XCURSOR_SIZE=24

            ${lib.getExe pkgs.niri} --config ${pkgs.writeText "niri-greet-config.kdl" ''

              ${lib.concatStringsSep "\n" (
                lib.mapAttrsToList (name: _m-cfg: ''
                  output "${name}" {
                    focus-at-startup
                    layout {
                      background-color "${palette.bg_base}"
                    }
                  }
                '') cfg.devices.monitors
              )}

              hotkey-overlay { skip-at-startup; }

              cursor {
                xcursor-theme "${cursor.name}"
                xcursor-size 24
              }

              window-rule {
                match at-startup=true
                open-fullscreen true
              }

              spawn-sh-at-startup "${lib.getExe pkgs.extra.mdgreet} --config ${
                (pkgs.formats.toml { }).generate "mdgreet.toml" {
                  appearance = {
                    greeting = "NixOS";
                    font_family = "Ubuntu";
                    theme = {
                      mode = config.matugen.mode;
                      name = "custom";
                      path = "${pkgs.writeText "mdgreet-theme.json" (
                        builtins.toJSON config.matugen.theme.custom.mdgreet
                      )}";
                    };
                    background = {
                      color = palette.bg_base;
                      path = "${config.assets.backgrounds.cat-leaves}";
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

    gvfs = {
      enable = lib.mkDefault config.desktop.enable;
    };

    lact = {
      enable = config.host.hardware.gpu.enable;
    };

    logind = {
      settings = {
        Login = {
          # add common logind attrs here ...
        }
        // lib.optionalAttrs config.desktop.devices.lid.enable {
          HandleLidSwitch = "suspend";
          HandleLidSwitchExternalPower = "suspend";
          HandleLidSwitchDocked = "ignore";
        };
      };
    };

    hardware = {
      openrgb = {
        enable = config.host.hardware.openRGB.enable;
        package = pkgs.openrgb-with-all-plugins;
        motherboard = config.host.hardware.motherboard.cpu;
      };
    };

    openssh = {
      enable = true;
      startWhenNeeded = true;
      allowSFTP = true;
      settings = {
        PermitRootLogin = "yes";
        PasswordAuthentication = true;
        LogLevel = "INFO";
      };
    };

    pipewire = {
      enable = true;
      alsa = {
        enable = true;
        support32Bit = true;
      };
      pulse = {
        enable = true;
      };
      wireplumber = {
        enable = true;
      };
    };

    printing = {
      enable = true;
      startWhenNeeded = true;
    };

    udev = {
      packages = [
        # add common udev packages here ...
      ]
      ++ lib.optionals config.host.hardware.ddcci.enable [ pkgs.ddcutil ];
    };

    upower = {
      enable = true;
      percentageLow = 15;
      percentageCritical = 5;
    };

    xray = {
      enable = true;
      settingsFile = "/etc/xray/config.json";
    };
  };
}
