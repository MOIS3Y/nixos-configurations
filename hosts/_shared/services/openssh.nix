# █▀█ █▀█ █▀▀ █▄░█ █▀ █▀ █░█ ▀
# █▄█ █▀▀ ██▄ █░▀█ ▄█ ▄█ █▀█ ▄
# -- -- -- -- -- -- -- -- -- -

{config, pkgs, ... }: {
  services.openssh = {
    enable = true;
    startWhenNeeded = true;
  };
}
