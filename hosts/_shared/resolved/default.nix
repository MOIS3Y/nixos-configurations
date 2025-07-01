# █▀█ █▀▀ █▀ █▀█ █░░ █░█ █▀▀ █▀▄ ▀
# █▀▄ ██▄ ▄█ █▄█ █▄▄ ▀▄▀ ██▄ █▄▀ ▄
# -- -- -- -- -- -- -- -- -- -- --

# systemd-resolved is a systemd service that provides network name resolution
# to local applications via a D-Bus interface,
# the resolve NSS service (nss-resolve(8)), 
# and a local DNS stub listener on 127.0.0.53.
# See systemd-resolved(8) for the usage.
# https://nixos.wiki/wiki/Systemd-resolved

# ? For me now a module is needed exclusively for launching wg-quick

{ ... }: {
  services.resolved.enable = true;
}
