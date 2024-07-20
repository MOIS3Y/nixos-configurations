# █▀▄ █▀▀ █░█ █▀▀ █░░ █▀█ █▀█ █▀▄▀█ █▀▀ █▄░█ ▀█▀ ▀
# █▄▀ ██▄ ▀▄▀ ██▄ █▄▄ █▄█ █▀▀ █░▀░█ ██▄ █░▀█ ░█░ ▄
# -- -- -- -- -- -

{ config, pkgs, ... }: {
  home.packages = with pkgs; [
    gettext
    gimp
    gnumake
    inkscape
    poetry
    sassc
    sqlitebrowser
    vault 
    vscode
    # Languages:
    (lua.withPackages(ps: with ps; [ luarocks ]))
    (python3.withPackages(ps: with ps; [ pip ]))
    # Extra-pkgs:
    extra.aladdin4nix
  ];
}
