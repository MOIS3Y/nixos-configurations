# █▀ █░█░█ ▄▀█ █▄█ █▀█ █▀ █▀▄ ▀
# ▄█ ▀▄▀▄▀ █▀█ ░█░ █▄█ ▄█ █▄▀ ▄
# -- -- -- -- -- -- -- -- -- --

{ config, pkgs, lib, ... }: let
  inherit (config.colorScheme)
    palette;
in {
  services.swayosd = {
    enable = lib.mkDefault config.desktop.wayland.enable;
    topMargin = 0.9;
    stylePath = pkgs.writeText "swayosd-style.css" ''
      window#osd {
        border-radius: 999px;
        border: none;
        background: #${palette.base00}e6;
      }

      window#osd #container {
        margin: 16px;
      }

      window#osd image,
      window#osd label {
        color: #${palette.base05};
      }

      window#osd progressbar:disabled,
      window#osd image:disabled {
        opacity: 0.5;
      }

      window#osd progressbar {
        min-height: 6px;
        border-radius: 999px;
        background: transparent;
        border: none;
      }

      window#osd trough {
        min-height: inherit;
        border-radius: inherit;
        border: none;
        background: #${palette.base01};
      }

      window#osd progress {
        min-height: inherit;
        border-radius: inherit;
        border: none;
        background: linear-gradient(
          to left, 
          #${palette.base08}, 
          #${palette.base09}, 
          #${palette.base0A}, 
          #${palette.base0B}, 
          #${palette.base0C}, 
          #${palette.base0D}, 
          #${palette.base0E}
        );
      }
    '';
  };
}
