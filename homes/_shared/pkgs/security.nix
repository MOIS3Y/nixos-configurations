# █▀ █▀▀ █▀▀ █░█ █▀█ █ ▀█▀ █▄█ ▀
# ▄█ ██▄ █▄▄ █▄█ █▀▄ █ ░█░ ░█░ ▄
# -- -- -- -- -- -- -- -- -- -

{ pkgs, ... }: {
  home.packages = with pkgs; [
    age
    sops
    totp-cli
  ];
}
