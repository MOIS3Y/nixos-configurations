# █▀▄ █ █▀█ █▀▀ █▄░█ █░█ ▀
# █▄▀ █ █▀▄ ██▄ █░▀█ ▀▄▀ ▄
# -- -- -- -- -- -- -- -- 

{ lib, ... }: {
  programs.direnv = {
    enable = lib.mkDefault true;
    enableZshIntegration = true;
    nix-direnv.enable = true;
  };
}
