# █▀▄▀█ █▀█ █░█ █▄░█ ▀█▀ █▀ ▀
# █░▀░█ █▄█ █▄█ █░▀█ ░█░ ▄█ ▄
# -- -- -- -- -- -- -- -- -- 

{ config, lib, ... }: {
  systemd.mounts = [
    # add default mounts here ...
  ] ++ lib.optionals (config.desktop.games.enable or null != null) [
    # games external storage (optional):
    (lib.mkIf config.desktop.games.externalStorage.enable {
      description = "Volume for storing installed games";
      what = config.desktop.games.externalStorage.storagePath;
      where = config.desktop.games.externalStorage.mountPath;
      type = "ext4";
      options = "user,rw,exec,noatime,nofail,x-systemd.idle-timeout=30s";
    })
  ];
}
