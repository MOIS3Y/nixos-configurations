# █ █▄░█ ▀█▀ █▀▀ █░░ ▀
# █ █░▀█ ░█░ ██▄ █▄▄ ▄
# -- -- -- -- -- -- --

{ config, pkgs, ... }: {
  hardware.cpu.intel.updateMicrocode = true;
}
