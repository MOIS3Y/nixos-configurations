# █░░ █▀█ ▄▀█ █▀▄ █▀▀ █▀█ ▀
# █▄▄ █▄█ █▀█ █▄▀ ██▄ █▀▄ ▄
# -- -- -- -- -- -- -- -- -
{ config, pkgs, ... }: {

  boot.loader = {
    grub = {
      device = "/dev/ata-HP_SSD_S650_120GB_HASA12100101184";
      configurationLimit = 7;
    };
  };
}
