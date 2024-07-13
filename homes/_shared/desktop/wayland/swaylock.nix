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

{ config, pkgs, lib, ... }: lib.mkIf config.desktop.wayland.enable {
  programs.swaylock = with config.colorScheme.palette; {
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

      font = "Ubuntu";
      timestr = "%T";
      datestr = "%a, %e %b %Y";
      # fade-in = "0.2";
      effect-blur = "8x5";
      effect-vignette = "0.5:0.5";

      # color = "00000000";

      bs-hl-color = "#${base08}";
      key-hl-color = "#${base0E}";
      
      caps-lock-bs-hl-color = "#${base09}";
      caps-lock-key-hl-color = "#${base09}";

      inside-color = "#${base01}";
      inside-clear-color = "#${base01}";
      inside-ver-color = "#${base01}";
      inside-wrong-color = "#${base01}";

      line-color = "#${base00}";
      line-ver-color = "#${base00}";
      line-clear-color = "#${base00}";
      line-wrong-color = "#${base00}";

      ring-color = "#${base02}";
      ring-clear-color = "#${base08}";
      ring-ver-color = "#${base08}";
      ring-wrong-color = "#${base08}";

      separator-color = "00000000";

      text-color = "#${base05}";
      text-clear-color = "#${base05}";
      text-ver-color = "#${base05}";
      text-wrong-color = "#${base08}";
    };
  };
}
