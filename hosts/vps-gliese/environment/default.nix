# █▀▀ █▄░█ █░█ █ █▀█ █▀█ █▄░█ █▀▄▀█ █▀▀ █▄░█ ▀█▀ ▀
# ██▄ █░▀█ ▀▄▀ █ █▀▄ █▄█ █░▀█ █░▀░█ ██▄ █░▀█ ░█░ ▄
# -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- 

{ config, pkgs, ... }: {
  imports = [
    ../../_shared/environment/variables.nix
    ../../_shared/environment/shells.nix
    ../../_shared/environment/pathsToLink.nix
  ];
  # ? Too small disk size
  environment.systemPackages = with pkgs; [
    bottom
    curl
    dnsutils
    git
    htop
    ncdu
    neovim
    nitch 
    wget  
  ];
}
