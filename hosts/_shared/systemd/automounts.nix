# ▄▀█ █░█ ▀█▀ █▀█ █▀▄▀█ █▀█ █░█ █▄░█ ▀█▀ █▀ ▀
# █▀█ █▄█ ░█░ █▄█ █░▀░█ █▄█ █▄█ █░▀█ ░█░ ▄█ ▄
# -- -- -- -- -- -- -- -- -- -- -- -- -- -- -

{ config, lib, ... }: {
  systemd.automounts = [
    # add default automounts here ...
  ] ++ lib.optionals (config.desktop.games.enable or null != null) [
    # automount games external storage (optional):
    (lib.mkIf config.desktop.games.externalStorage.enable {
      description = "Mount on-demand storage for games";
      where = config.desktop.games.externalStorage.mountPath;
      automountConfig = {
        TimeoutIdleSec = 30;
      };
      wantedBy = [ "multi-user.target" ];
    })
  ];
}
