# █▀█ █▀█ █▀▀ █▄░█ █▀▀ █░░ ▀
# █▄█ █▀▀ ██▄ █░▀█ █▄█ █▄▄ ▄
# -- -- -- -- -- -- -- -- --

# ! deprecated option since Jul 10 2024 now it in hardware.graphics

{ config, pkgs, ... }: {
  hardware.opengl = {
    enable = true;
    driSupport = true;
    driSupport32Bit = true;
  };
}
