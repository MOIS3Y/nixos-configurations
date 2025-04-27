# █░█ █▀█ █▀▄▀█ █▀▀ ▄▄ █▀▄▀█ ▄▀█ █▄░█ ▄▀█ █▀▀ █▀▀ █▀█ ▀
# █▀█ █▄█ █░▀░█ ██▄ ░░ █░▀░█ █▀█ █░▀█ █▀█ █▄█ ██▄ █▀▄ ▄
# -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- --

{ pkgs, lib, ... }: {
  imports = [
    # Custom modules
    ../../modules/colors
    # Shared configuration
    ../_shared/programs
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
    neofetch
    procps
    ripgrep
    tree
    unrar
    unzip
    wget
    xz
    zip
  ];

  programs.htop.os = "android";
  programs.ssh.userMatchBlocks = "nix-on-droid";
  programs.zsh.shellAliases = lib.mkForce { shutdown = "exec shutdown"; };
  programs.zsh.oh-my-zsh.plugins = lib.mkForce [ "git" "ssh-agent" ];

  home.stateVersion = "24.05";
}
