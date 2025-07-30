# ▀█▀ █░░ █▀█ ▀
# ░█░ █▄▄ █▀▀ ▄
# -- -- -- -- -

{config, ... }: {
  services.tlp = {
    enable = config.desktop.devices.battery.enable;
  };
}
