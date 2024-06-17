# █▀▄ █▀▀ █░█ █▀▀ █░░ █▀█ █▀█ █▀▄▀█ █▀▀ █▄░█ ▀█▀ ▀
# █▄▀ ██▄ ▀▄▀ ██▄ █▄▄ █▄█ █▀▀ █░▀░█ ██▄ █░▀█ ░█░ ▄
# -- -- -- -- -- -

{ config, pkgs, ... }: {
  home.packages = with pkgs; [
    gettext
    gimp
    gnumake
    gradience
    inkscape
    poetry
    sassc
    sqlitebrowser
    vault 
    vscode
    # Extra-pkgs:
    extrapkgs.aladdin4nix
  ];
}
