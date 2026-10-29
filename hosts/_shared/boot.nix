# █▄▄ █▀█ █▀█ ▀█▀ ▀
# █▄█ █▄█ █▄█ ░█░ ▄
# -- -- -- -- -- --
# Sets up the bootloader, kernel parameters and early boot modules.

{
  inputs,
  config,
  pkgs,
  ...
}:
let
  system = pkgs.stdenv.hostPlatform.system;
  cfg = config.host.boot;
  theme = inputs.distro-grub-themes.packages.${system}."${cfg.grubTheme}-grub-theme";
in
{
  boot = {
    consoleLogLevel = 0;
    kernelParams = [
      "quiet"
      "udev.log_level=3"
    ];
    loader = {
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
    plymouth = {
      enable = true;
      themePackages = [ pkgs.adi1090x-plymouth-themes ];
      theme = "connect";
    };
  };
}
