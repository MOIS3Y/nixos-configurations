# ▄▀█ █░█ ▀█▀ █▀█ █▀▄▀█ █▀█ █░█ █▄░█ ▀█▀ █▀ ▀
# █▀█ █▄█ ░█░ █▄█ █░▀░█ █▄█ █▄█ █░▀█ ░█░ ▄█ ▄
# -- -- -- -- -- -- -- -- -- -- -- -- -- -- -

{ config, pkgs, ... }: {
  systemd.automounts = [
    {
      description = "Mount on-demand storage for games";
      where = "/home/stepan/Games";
      automountConfig = {
        TimeoutIdleSec = 30;
      };
      wantedBy = [ "multi-user.target" ];
    }
  ];
}
