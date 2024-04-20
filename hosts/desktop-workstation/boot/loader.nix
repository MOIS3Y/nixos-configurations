# █░░ █▀█ ▄▀█ █▀▄ █▀▀ █▀█ ▀
# █▄▄ █▄█ █▀█ █▄▀ ██▄ █▀▄ ▄
# -- -- -- -- -- -- -- -- -
{ config, pkgs, ... }: {

  boot.loader = {
    efi = {
      canTouchEfiVariables = true;
      efiSysMountPoint = "/boot/efi";
    };
    grub = {
      devices = ["nodev"];
      efiSupport = true;
      useOSProber = true;
      configurationLimit = 5;
      gfxmodeEfi = "1920x1080";
      theme = pkgs.fetchzip {
        name = "grub-theme-msi";
        url = https://github.com/AdisonCavani/distro-grub-themes/releases/download/v3.2/msi.tar;
        hash = "sha256-4+DzRtdu8F9RRR+XrN8SPPnUOVOIgHr2vYOPqI1vcDM=";
        stripRoot = false;
      };
    };
  };
}
