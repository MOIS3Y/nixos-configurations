# █▀▀ █▀█ █░░ █▀█ █▀█ █▀ ▀
# █▄▄ █▄█ █▄▄ █▄█ █▀▄ ▄█ ▄
# -- -- -- -- -- -- -- -- 

{ config, pkgs, ... }: {
  imports = [
    ./module.nix
  ];
  # ? current scheme for all devices:
  colorSchemeName = "catppuccin_mocha";
}
