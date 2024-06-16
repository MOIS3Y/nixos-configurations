# █▀ █░█░█ ▄▀█ █▄█ █░░ █▀█ █▀▀ █▄▀ ▀
# ▄█ ▀▄▀▄▀ █▀█ ░█░ █▄▄ █▄█ █▄▄ █░█ ▄
# -- -- -- -- -- - -- -- -- -- -- --
# ! Note
# that PAM must be configured to enable swaylock to perform
# authentication. The package installed through home-manager
# will *not* be able to unlock the session without this
# configuration.

# On NixOS, this is by default enabled with the sway module, but
# for other compositors it can currently be enabled using:

# ```nix
# security.pam.services.swaylock = {};
# ```
# -- -- -- -- -- - -- -- -- -- -- --

{ config, pkgs, ... }: {
  programs.swaylock = {
    enable = true;
    package = pkgs.swaylock-effects;
    settings = {
      screenshots = true;
      clock = true;
      indicator = true;
      indicator-radius = 120;
      indicator-thickness = 15;
      grace = 2;
      grace-no-mouse = true;
      grace-no-touch = true;
      line-uses-ring = false;
      ignore-empty-password = true;
      show-failed-attempts = false;
      hide-keyboard-layout = true;

      font = "Inter";
      timestr = "%T";
      datestr = "%a, %e %b %Y";
      # fade-in = "0.2";
      effect-blur = "8x5";
      effect-vignette = "0.5:0.5";

      # color = "00000000";

      bs-hl-color = "#${config.colorScheme.palette.base08}";
      key-hl-color = "#${config.colorScheme.palette.base0E}";
      
      caps-lock-bs-hl-color = "#${config.colorScheme.palette.base09}";
      caps-lock-key-hl-color = "#${config.colorScheme.palette.base09}";

      inside-color = "#${config.colorScheme.palette.base01}";
      inside-clear-color = "#${config.colorScheme.palette.base01}";
      inside-ver-color = "#${config.colorScheme.palette.base01}";
      inside-wrong-color = "#${config.colorScheme.palette.base01}";

      line-color = "#${config.colorScheme.palette.base00}";
      line-ver-color = "#${config.colorScheme.palette.base00}";
      line-clear-color = "#${config.colorScheme.palette.base00}";
      line-wrong-color = "#${config.colorScheme.palette.base00}";

      ring-color = "#${config.colorScheme.palette.base02}";
      ring-clear-color = "#${config.colorScheme.palette.base08}";
      ring-ver-color = "#${config.colorScheme.palette.base08}";
      ring-wrong-color = "#${config.colorScheme.palette.base08}";

      separator-color = "00000000";

      text-color = "#${config.colorScheme.palette.base05}";
      text-clear-color = "#${config.colorScheme.palette.base05}";
      text-ver-color = "#${config.colorScheme.palette.base05}";
      text-wrong-color = "#${config.colorScheme.palette.base08}";
    };
  };
}
