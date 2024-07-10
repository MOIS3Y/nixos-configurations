# █▀▀ █▀█ █▀▄▀█ █▀▄▀█ █▀█ █▄░█ ▀
# █▄▄ █▄█ █░▀░█ █░▀░█ █▄█ █░▀█ ▄
# -- -- -- -- -- -- -- -- -- -- 

{ config, pkgs, ... }: {
  environment.systemPackages = with pkgs; [
    cmatrix
    # ! neofetch breaks the build since Jul 10 2024
    # ? see: https://discourse.nixos.org/t/error-nose-1-3-7-not-supported-for-interpreter-python3-12/48703/9
    # ? and https://github.com/NixOS/nixpkgs/issues/325657
    # neofetch
    nitch
    tty-clock
  ];
}
