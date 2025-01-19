# █▀ █▀▀ █▀█ █░█ █ █▀▀ █▀▀ █▀ ▀
# ▄█ ██▄ █▀▄ ▀▄▀ █ █▄▄ ██▄ ▄█ ▄
# -- -- -- -- -- -- -- -- -- --

{ config, pkgs, ... }: {
  # ! required for blueman-applet HM-systemd-service (hide error msg)
  services.blueman.enable = true;
  # ! fix l2tp vpn:
  # ? see: https://github.com/NixOS/nixpkgs/issues/217628
  services.strongswan = {
    enable = true;
    secrets = [
      "ipsec.d/ipsec.nm-l2tp.secrets"
    ];
  };
  environment.etc."strongswan.conf".text = "";
}
