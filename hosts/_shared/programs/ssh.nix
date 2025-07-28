# █▀ █▀ █░█ ▀
# ▄█ ▄█ █▀█ ▄
#  -- -- -- -

{ config, lib, ... }: {
  programs.ssh = {
    startAgent = lib.mkIf (!config.services.gnome.gnome-keyring.enable) true;
  };
}
