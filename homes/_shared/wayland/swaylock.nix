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

      bs-hl-color = "#f38ba8";
      key-hl-color = "#cba6f7";
      
      caps-lock-bs-hl-color = "#fab387";
      caps-lock-key-hl-color = "#fab387";

      inside-color = "#1e1e2e";
      inside-clear-color = "#1e1e2e";
      inside-ver-color = "#1e1e2e";
      inside-wrong-color = "#1e1e2e";

      line-color = "#11111b";
      line-ver-color = "#11111b";
      line-clear-color = "#11111b";
      line-wrong-color = "#11111b";

      ring-color = "#181825";
      ring-clear-color = "#cba6f7";
      ring-ver-color = "#cba6f7";
      ring-wrong-color = "#f38ba8";

      separator-color = "00000000";

      text-color = "#cdd6f4";
      text-clear-color = "#cdd6f4";
      text-ver-color = "#cdd6f4";
      text-wrong-color = "#f38ba8";
    };
  };
}
