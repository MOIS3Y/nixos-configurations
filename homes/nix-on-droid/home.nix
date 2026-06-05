# █▄░█ █ ▀▄▀   █▀█ █▄░█   █▀▄ █▀█ █▀█ █ █▀▄ ▀
# █░▀█ █ █░█   █▄█ █░▀█   █▄▀ █▀▄ █▄█ █ █▄▀ ▄
# -- -- -- -- -- -- -- -- -- -- -- -- -- -- -
# Home Manager configuration for Nix-on-Droid environments.

{ pkgs, lib, ... }:
{
  imports = [
    # Custom modules
    ../../modules/appearance
    # Shared configuration
    ../_shared/programs/ssh.nix
    ../_shared/programs/direnv.nix
    ../_shared/programs/git.nix
    ../_shared/programs/htop.nix
    ../_shared/programs/lsd.nix
    ../_shared/programs/nvchad.nix
    ../_shared/programs/ruff.nix
    ../_shared/programs/zsh.nix
  ];

  home.packages = with pkgs; [
    bzip2
    cmatrix
    curl
    direnv
    diffutils
    dnsutils
    findutils
    gnugrep
    gnused
    gnutar
    gzip
    hostname
    jq
    man
    nettools
    ncurses
    nix-direnv
    fastfetch
    procps
    ripgrep
    tree
    unrar
    unzip
    wget
    xz
    zip
  ];

  # Override _shared configuration:
  programs.htop.os = "android";
  programs.zsh.shellAliases = lib.mkForce { shutdown = "exec shutdown"; };
  programs.zsh.oh-my-zsh.plugins = lib.mkForce [
    "git"
    "ssh-agent"
  ];

  home.stateVersion = "24.05";
}
