# █▄░█ █▀▀ ▀█▀ █░█░█ █▀█ █▀█ █▄▀ █ █▄░█ █▀▀ ▀
# █░▀█ ██▄ ░█░ ▀▄▀▄▀ █▄█ █▀▄ █░█ █ █░▀█ █▄█ ▄
# -- -- -- -- -- -- -- -- -- -- -- -- -- -- -

{ pkgs, lib, ... }: {
  networking = {
    hostName = lib.mkDefault "dummy-hostname";
    networkmanager = {
      enable = true;
      enableStrongSwan = true;
      plugins = with pkgs; [
        networkmanager-l2tp
        networkmanager-openvpn
        networkmanager-openconnect
      ];
      appendNameservers = [ "8.8.8.8" ];
    };
  };
  # ! fix l2tp vpn:
  # ? see: https://github.com/NixOS/nixpkgs/issues/375352
  environment.etc."strongswan.conf".text = "";
}
