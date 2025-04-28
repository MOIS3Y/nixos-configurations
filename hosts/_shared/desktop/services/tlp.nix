# ▀█▀ █░░ █▀█ ▀
# ░█░ █▄▄ █▀▀ ▄
# -- -- -- -- -

{config, lib, ... }: {
  services.tlp = lib.mkIf config.desktop.devices.battery.enable {
    enable = true;
  };
}