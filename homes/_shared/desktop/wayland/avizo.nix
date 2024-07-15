# ▄▀█ █░█ █ ▀█ █▀█ ▀
# █▀█ ▀▄▀ █ █▄ █▄█ ▄
# -- -- -- -- -- -- 

{ config, pkgs, lib, ... }: lib.mkIf config.desktop.wayland.enable {
  services.avizo = {
    enable = true;
    # ? workaround avizo ignore image-base-dir
    # ? see: https://github.com/heyjuvi/avizo/issues/60
    package = pkgs.avizo.overrideAttrs (final: prev: {
      patchPhase = ''
        cp ${config.desktop.assets.icons}/avizo/${config.colorScheme.name}/* data/images/
      '';
    });
    settings = with config.colorScheme.palette; {
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
        background = "#${base00}";
        border-color = "#${base01}";
        bar-fg-color = "#${base05}";
        bar-bg-color = "#${base02}";
        time = 2;
        # monitor = INT;
      };
    };
  };
}
