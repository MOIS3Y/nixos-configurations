# █░█ █▀ █▀▀ █▀█ ▀
# █▄█ ▄█ ██▄ █▀▄ ▄
# -- -- -- -- -- -

{ pkgs, lib, ... }: {
  user.shell = "${lib.getExe pkgs.zsh}";
}

