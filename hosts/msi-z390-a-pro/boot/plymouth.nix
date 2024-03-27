# █▀█ █░░ █▄█ █▀▄▀█ █▀█ █░█ ▀█▀ █░█ ▀
# █▀▀ █▄▄ ░█░ █░▀░█ █▄█ █▄█ ░█░ █▀█ ▄
# -- -- -- -- -- -- -- -- -- -- -- --

{config, pkgs, ...}: {
  boot.plymouth = {
  enable = true;
  themePackages = [
    # (pkgs.catppuccin-plymouth.override { variant = "mocha"; })
    pkgs.adi1090x-plymouth-themes
  ];
  theme = "connect";
  };
}
