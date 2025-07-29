# █▄░█ █░█ ▀
# █░▀█ █▀█ ▄
# -- -- -- -

{ config, ... }: {
  programs.nh = {
    enable = true;
    flake = config.host.flake;
  };
}
