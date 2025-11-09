# █░░ █▀█ ▄▀█ █▀▄ █▀▀ █▀█ ▀
# █▄▄ █▄█ █▀█ █▄▀ ██▄ █▀▄ ▄
# -- -- -- -- -- -- -- -- -

{ inputs, config, pkgs, ... }: let
  system = pkgs.stdenv.hostPlatform.system;
  cfg = config.host.boot;
  theme = inputs.distro-grub-themes.packages.${system}."${cfg.grubTheme}-grub-theme";
in {
  boot.loader = {
    efi = {
      canTouchEfiVariables = true;
      efiSysMountPoint = "/boot/efi";
    };
    grub = {
      devices = [ "nodev" ];
      efiSupport = true;
      useOSProber = true;
      configurationLimit = 5;
      gfxmodeEfi = "1920x1080";
      splashImage = "${theme}/splash_image.jpg";
      inherit theme;
    };
  };
}
