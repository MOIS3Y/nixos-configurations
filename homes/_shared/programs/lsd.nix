# █░░ █▀ █▀▄ ▀
# █▄▄ ▄█ █▄▀ ▄
# -- -- -- -- 

{ lib, ... }: {
  programs.lsd = {
    enable = lib.mkDefault true;
  };
}
