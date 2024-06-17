# █▀▀ ▄▀█ █▀▄▀█ █▀▀ ▀
# █▄█ █▀█ █░▀░█ ██▄ ▄
# -- -- -- -- -- -- -

{ config, pkgs, ... }: {
  home.packages = with pkgs; [
    (lutris.override {
      extraPkgs = pkgs: with pkgs; [
        winePackages.unstableFull
      ];
    })
    protonup-qt
  ];
}
