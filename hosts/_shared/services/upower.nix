# █░█ █▀█ █▀█ █░█░█ █▀▀ █▀█ ▀
# █▄█ █▀▀ █▄█ ▀▄▀▄▀ ██▄ █▀▄ ▄
# -- -- -- -- -- -- -- -- -- 

{ ... }: {
  services.upower = {
    enable = true;
    percentageLow = 15;
    percentageCritical = 5;
  };
}