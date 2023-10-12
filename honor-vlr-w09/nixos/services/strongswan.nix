# █▀ ▀█▀ █▀█ █▀█ █▄░█ █▀▀ █▀ █░█░█ ▄▀█ █▄░█ ▀
# ▄█ ░█░ █▀▄ █▄█ █░▀█ █▄█ ▄█ ▀▄▀▄▀ █▀█ █░▀█ ▄
# -- -- -- -- -- -- -- -- -- -- -- -- -- -- -

{config, pkgs, ... }: {
  # fix l2tp vpn:
  services.strongswan = {
    enable = true;
    secrets = [
      "ipsec.d/ipsec.nm-l2tp.secrets"
    ];
  };
}
