# █▀ █▀ █░█ ▀
# ▄█ ▄█ █▀█ ▄
#  -- -- -- -

{ config, ... }: {
  programs.ssh = {
    startAgent = !config.services.gnome.gnome-keyring.enable;
  };
}
