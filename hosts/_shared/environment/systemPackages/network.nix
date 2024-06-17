# █▄░█ █▀▀ ▀█▀ █░█░█ █▀█ █▀█ █▄▀ ▀
# █░▀█ ██▄ ░█░ ▀▄▀▄▀ █▄█ █▀▄ █░█ ▄
# -- -- -- -- -- -- -- -- -- -

{ config, pkgs, ... }: {
  environment.systemPackages = with pkgs; [
    curl
    dnsutils
    nmap
    wget
  ];
}
