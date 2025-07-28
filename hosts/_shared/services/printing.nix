# █▀█ █▀█ █ █▄░█ ▀█▀ █ █▄░█ █▀▀ ▀
# █▀▀ █▀▄ █ █░▀█ ░█░ █ █░▀█ █▄█ ▄
# -- -- -- -- -- -- -- -- -- -- -

{ ... }: {
  services.printing = {
    enable = true;
    startWhenNeeded = true;
  };
}
