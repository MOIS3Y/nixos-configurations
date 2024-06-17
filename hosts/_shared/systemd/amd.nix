# ▄▀█ █▀▄▀█ █▀▄ ▀
# █▀█ █░▀░█ █▄▀ ▄
# -- -- -- -- -- 

{ config, pkgs, ... }: {
  # ? daemon required for managment gpu settings
  # ? see: https://github.com/NixOS/nixpkgs/issues/317544
  systemd.packages = with pkgs; [ lact ];
  systemd.services.lactd = {
    enable = true; # this is true by default
    wantedBy = [ "multi-user.target" ]; # auto start at boot time 
  };
}
