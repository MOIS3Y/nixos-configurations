# ▄▀█ █▀▄▀█ █▀▄ ▀
# █▀█ █░▀░█ █▄▀ ▄
# -- -- -- -- -- 

{ config, pkgs, ... }: {
  boot.extraModprobeConfig = ''
    options amdgpu ppfeaturemask=0xFFF7FFFF
  '';
}