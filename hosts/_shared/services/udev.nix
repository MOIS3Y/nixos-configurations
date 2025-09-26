# █░█ █▀▄ █▀▀ █░█ ▀
# █▄█ █▄▀ ██▄ ▀▄▀ ▄
# -- -- -- -- -- --

{ config, pkgs, lib, ... }: {
  services.udev = {
    packages = [ ]
      #! MSI Monitor, Model:G2712
      ++ lib.optionals config.host.hardware.ddcci.enable [ pkgs.ddcutil ]
      ++ lib.optionals config.desktop.wayland.enable [ pkgs.swayosd ]
    ;
  };
}
