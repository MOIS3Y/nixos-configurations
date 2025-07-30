# █▀▀ █▀█ █▀█ █░░ █▀▀ █▀█ █▀▀ █▀█ █▄░█ ▀█▀ █▀█ █▀█ █░░ ▀
# █▄▄ █▄█ █▄█ █▄▄ ██▄ █▀▄ █▄▄ █▄█ █░▀█ ░█░ █▀▄ █▄█ █▄▄ ▄
# -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- 

{config, ... }: {
  programs.coolercontrol =  {
    enable = config.host.hardware.coolercontrol.enable;
  };
}
