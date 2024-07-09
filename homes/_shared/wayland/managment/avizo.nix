# ▄▀█ █░█ █ ▀█ █▀█ ▀
# █▀█ ▀▄▀ █ █▄ █▄█ ▄
# -- -- -- -- -- -- 

{ config, pkgs, ... }: {
  services.avizo = {
    enable = true;
    # ? workaround avizo ignore image-base-dir
    # ? see: https://github.com/heyjuvi/avizo/issues/60
    package = pkgs.avizo.overrideAttrs (final: prev: {
      patchPhase = ''
        cp ${pkgs.extrapkgs.assets4nix}/share/icons/avizo/${config.colorScheme.name}/* data/images/
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
        background = "#${config.colorScheme.palette.base00}";
        border-color = "#${config.colorScheme.palette.base01}";
        bar-fg-color = "#${config.colorScheme.palette.base05}";
        bar-bg-color = "#${config.colorScheme.palette.base02}";
        time = 2;
        # monitor = INT;
        #image-base-dir = "${pkgs.extrapkgs.assets4nix}/share/icons/avizo/${config.colorScheme.name}";
      };
    };
  };
}
