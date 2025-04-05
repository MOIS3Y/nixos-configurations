# ▄▀█ █░█ █ ▀█ █▀█ ▀
# █▀█ ▀▄▀ █ █▄ █▄█ ▄
# -- -- -- -- -- -- 

{ config, pkgs, lib, ... }: let
  cfg = config.desktop.wayland;
  inherit (config.colorScheme)
    name
    palette;
  inherit (config.desktop.assets)
    icons;
  in {
  services.avizo = {
    enable = cfg.enable;
    # ? workaround avizo ignore image-base-dir
    # ? see: https://github.com/heyjuvi/avizo/issues/60
    package = pkgs.avizo.overrideAttrs (final: prev: {
      patchPhase = ''
        cp -r ${icons}/avizo/${name}/* data/images/
      '';
    });
    settings = {
      default = {
        # image-opacity=DOUBLE;
        # progress="0.1";
        width = 200;
        height = 200;
        y-offset = "0.5";
        padding = 20;
        border-radius = 16;
        border-width = 1;
        block-height = 9;
        block-spacing = 4;
        block-count = 18;
        fade-in = "0.2";
        fade-out = "0.5";
        background = "#${palette.base00}";
        border-color = "#${palette.base01}";
        bar-fg-color = "#${palette.base05}";
        bar-bg-color = "#${palette.base02}";
        time = 2;
        # monitor = INT;
      };
    };
  };
}
