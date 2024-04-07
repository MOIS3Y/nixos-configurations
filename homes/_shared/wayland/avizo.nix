# ▄▀█ █░█ █ ▀█ █▀█ ▀
# █▀█ ▀▄▀ █ █▄ █▄█ ▄
# -- -- -- -- -- -- 

{ config, pkgs, ... }: {
  services.avizo = {
    enable = true;
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
        block-height = 15;
        block-spacing = 4;
        block-count = 10;
        fade-in = "0.2";
        fade-out = "0.5";
        background = "#${config.colorScheme.palette.base00}";
        border-color = "#${config.colorScheme.palette.base01}";
        bar-fg-color = "#${config.colorScheme.palette.base0E}";
        bar-bg-color = "#${config.colorScheme.palette.base01}";
        time = 2;
        # monitor = INT;
      };
    };
  };
}
