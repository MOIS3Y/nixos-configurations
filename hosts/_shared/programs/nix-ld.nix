# █▄░█ █ ▀▄▀ ▄▄ █░░ █▀▄ ▀
# █░▀█ █ █░█ ░░ █▄▄ █▄▀ ▄
# -- -- -- -- -- -- -- --
# ? read about nix-ld: https://wiki.nixos.org/wiki/Nix-ld

{ ... }: {
  programs.nix-ld = {
    enable = true;
  };
}
