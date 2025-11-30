# ▀▄▀ █▀█ ▄▀█ █▄█ ▀
# █░█ █▀▄ █▀█ ░█░ ▄
# -- -- -- -- -- --

{ ... }: {
  services.xray = {
    enable = true;
    settingsFile = "/etc/xray/config.json";
  };
}
