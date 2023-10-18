# █▀█ █░░ █▄█ █▀▄▀█ █▀█ █░█ ▀█▀ █░█ ▀
# █▀▀ █▄▄ ░█░ █░▀░█ █▄█ █▄█ ░█░ █▀█ ▄
# -- -- -- -- -- -- -- -- -- -- -- --

{config, pkgs, ...}: {
  boot.plymouth = {
  enable = true;
  themePackages = [
    (pkgs.catppuccin-plymouth.override { variant = "mocha"; })
  ];
  theme = "catppuccin-mocha";
  };
}
