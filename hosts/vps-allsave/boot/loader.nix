# █░░ █▀█ ▄▀█ █▀▄ █▀▀ █▀█ ▀
# █▄▄ █▄█ █▀█ █▄▀ ██▄ █▀▄ ▄
# -- -- -- -- -- -- -- -- -
{ config, pkgs, ... }: {

  boot.loader = {
    grub = {
      device = "/dev/disk/by-id/ata-HP_SSD_S650_120GB_HASA12100101184";
      configurationLimit = 7;
    };
  };
}
