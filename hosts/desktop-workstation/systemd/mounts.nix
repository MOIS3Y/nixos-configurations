# █▀▄▀█ █▀█ █░█ █▄░█ ▀█▀ █▀ ▀
# █░▀░█ █▄█ █▄█ █░▀█ ░█░ ▄█ ▄
# -- -- -- -- -- -- -- -- -- 

{ config, pkgs, ... }: {
  systemd.mounts = [
    {
      description = "Volume for storing installed games";
      what = "/dev/disk/by-label/games";
      where = "/home/stepan/Games";
      type = "ext4";
      options = "user,rw,exec,noatime,nofail,x-systemd.idle-timeout=30s";
    }
  ];
}
