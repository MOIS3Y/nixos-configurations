# █▀▄▀█ ▄▀█ █▄░█ ▄▀█ █▀▀ █▀▄▀█ █▀▀ █▄░█ ▀█▀ ▀
# █░▀░█ █▀█ █░▀█ █▀█ █▄█ █░▀░█ ██▄ █░▀█ ░█░ ▄
# -- -- -- -- -- -- -- -- -- -- -- -- -- -- -

{ config, pkgs, ... }: {
  environment.systemPackages = with pkgs; [
    docker-compose
    git
    jq
    ntfs3g
    neovim
    rsync
    ripgrep
    tree
    unzip
  ];
}
