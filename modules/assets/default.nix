# ▄▀█ █▀ █▀ █▀▀ ▀█▀ █▀ ▀
# █▀█ ▄█ ▄█ ██▄ ░█░ ▄█ ▄
# -- -- -- -- -- -- -- -

{ config, pkgs, ... }: {
  imports = [
    ./module.nix
  ];
  # ? current assets for all desktop devices:
  desktop.assets = with config.colorScheme; with config.desktop.assets; {
    # Images:
    background = "${backgrounds}/share/images/backgrounds/hexagon/${name}.png";
    wallpaper = "${wallpapers}/share/images/wallpapers/hexagon/${name}.png";
    # Sounds:
    volume-beep = "${sounds}/system/all-eyes-on-me.mp3";
  };
}
