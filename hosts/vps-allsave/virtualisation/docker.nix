# █▀▄ █▀█ █▀▀ █▄▀ █▀▀ █▀█ ▀
# █▄▀ █▄█ █▄▄ █░█ ██▄ █▀▄ ▄
# -- -- -- -- -- -- -- -- -

{ config, pkgs, ... }: {
  virtualisation.docker = {
    enable = true;
    daemon.settings = {
      data-root = "/services/docker/engine";
    };
  };
}
