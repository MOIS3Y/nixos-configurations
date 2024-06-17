# ▄▀█ █▀▄▀█ █▀▄ ▀
# █▀█ █░▀░█ █▄▀ ▄
# -- -- -- -- -- 

{ config, pkgs, ... }: {
  environment.systemPackages = with pkgs; [
    nvtopPackages.amd
    amdgpu_top
    lact
  ];
}
