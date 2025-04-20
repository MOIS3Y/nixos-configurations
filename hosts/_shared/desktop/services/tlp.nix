# ▀█▀ █░░ █▀█ ▀
# ░█░ █▄▄ █▀▀ ▄
# -- -- -- -- -

{config, lib, ... }: {
  services.tlp = lib.mkIf config.desktop.laptop.enable {
    enable = true;
  };
}