# █░█ █▄█ █▀█ █▀█ █▀█ ▄▀█ █▀█ █▀▀ █▀█ ▀
# █▀█ ░█░ █▀▀ █▀▄ █▀▀ █▀█ █▀▀ ██▄ █▀▄ ▄
# -- -- -- -- -- -- -- -- -- -- -- -- -

{ config, pkgs, ...}: {
  services.hyprpaper = {
    enable = true;
    package = pkgs.hyprpaper;
    settings = {
      ipc = "on";
      splash = false;
      splash_offset = 2.0;
      preload = [
        "${pkgs.extrapkgs.assets4nix}/share/wallpapers/hexagon/${config.colorScheme.name}.png"
        # add more here ...
      ];
      wallpaper = [
        ",${pkgs.extrapkgs.assets4nix}/share/wallpapers/hexagon/${config.colorScheme.name}.png"
        # ? above for all monitors
      ];
    };
  };
}
