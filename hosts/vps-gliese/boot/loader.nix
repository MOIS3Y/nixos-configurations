# █░░ █▀█ ▄▀█ █▀▄ █▀▀ █▀█ ▀
# █▄▄ █▄█ █▀█ █▄▀ ██▄ █▀▄ ▄
# -- -- -- -- -- -- -- -- -
{ config, pkgs, ... }: {

  boot.loader = {
    grub = {
      device = "/dev/vda";
      configurationLimit = 7;
    };
  };
}
