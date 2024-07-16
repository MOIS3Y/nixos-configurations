# ▄▀█ █▀ █▀ █▀▀ ▀█▀ █▀ ▀
# █▀█ ▄█ ▄█ ██▄ ░█░ ▄█ ▄
# -- -- -- -- -- -- -- -

{ config, pkgs, ... }: {
  imports = [
    ./module.nix
  ];
  # ? current assets for all desktop devices:
  desktop.assets = with config.colorScheme; with config.desktop.assets; {
    images = {
      background = "${images.backgrounds}/hexagon/${name}.png";
      wallpaper = "${images.wallpapers}/hexagon/${name}.png";
    };
    sounds = {
      # Beepers:
      switch-beep = "${sounds.system}/knob.mp3";
      toggle-beep = "${sounds.system}/sly.mp3";
      open-beep = "${sounds.system}/opening.mp3";
      volume-beep = "${sounds.system}/all-eyes-on-me.mp3";
      # Notifications:
      warning-notification = "${sounds.alarm}/answer-quickly.mp3";
    };
  };
}
