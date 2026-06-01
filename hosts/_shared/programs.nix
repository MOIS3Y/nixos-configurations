# █▀█ █▀█ █▀█ █▀▀ █▀█ ▄▀█ █▀▄▀█ █▀ ▀
# █▀▀ █▀▄ █▄█ █▄█ █▀▄ █▀█ █░▀░█ ▄█ ▄
# -- -- -- -- -- -- -- -- -- -- --
# Configures core system programs and their global states.

{
  config,
  pkgs,
  lib,
  ...
}:
let
  cfg = config.desktop;
in
{
  assertions = [
    {
      assertion = ((cfg.compositors != [ ]) -> !config.services.desktopManager.gnome.enable);
      message = ''
        [Configuration Error] dms-shell and GNOME are mutually exclusive!

        Problem detected:
        - Standalone compositors are requested in `desktop.compositors` (triggering dms-shell).
        - GNOME is enabled via `services.desktopManager.gnome.enable`.

        Required action:
        Disable GNOME to use standalone compositors with dms-shell.
      '';
    }
    {
      assertion = (lib.lists.elem "niri" cfg.compositors -> !config.services.desktopManager.gnome.enable);
      message = ''
        [Configuration Error] Niri and GNOME are mutually exclusive!

        Problem detected:
        - Niri is requested in `desktop.compositors`.
        - GNOME is enabled via `services.desktopManager.gnome.enable`.

        Required action:
        Disable GNOME to use Niri as a standalone compositor.
      '';
    }
  ];

  programs = {
    coolercontrol = {
      enable = config.host.hardware.coolercontrol.enable;
    };

    dconf = {
      enable = lib.mkDefault config.desktop.enable;
    };

    dms-shell = {
      enable = (cfg.compositors != [ ] && !config.services.desktopManager.gnome.enable);
    };

    gamescope = {
      enable = config.desktop.games.enable;
      # ! broken: steam: setuid use of bubblewrap is not supported in this build
      # ? see: https://github.com/NixOS/nixpkgs/issues/523200
      capSysNice = false;
    };

    geary = {
      enable = lib.mkDefault config.desktop.enable;
    };

    nh = {
      enable = true;
      flake = config.host.flake;
    };

    niri = {
      enable = lib.lists.elem "niri" cfg.compositors;
    };

    nix-ld = {
      enable = true;
    };

    ssh = {
      startAgent = !config.services.gnome.gnome-keyring.enable;
    };

    steam = {
      enable = config.desktop.games.enable;
      extest = {
        enable = config.desktop.enable;
      };
      gamescopeSession = {
        enable = true;
      };
    };

    wireshark = {
      enable = true;
      package = pkgs.wireshark;
    };

    zsh = {
      enable = true;
    };
  };
}
