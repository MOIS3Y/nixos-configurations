# █░█ █▀█ █▀▄▀█ █▀▀ ▄▄ █▀▄▀█ ▄▀█ █▄░█ ▄▀█ █▀▀ █▀▀ █▀█ ▀
# █▀█ █▄█ █░▀░█ ██▄ ░░ █░▀░█ █▀█ █░▀█ █▀█ █▄█ ██▄ █▀▄ ▄
# -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- --

{ pkgs, lib, ... }: {
  imports = [
    # Custom modules
    ../../modules/colors
    # Shared configuration
    ../_shared/programs/ssh
    ../_shared/programs/direnv.nix
    ../_shared/programs/git.nix
    ../_shared/programs/helix.nix
    ../_shared/programs/htop.nix
    ../_shared/programs/lf.nix
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

  # Override _shared configuration:
  programs.htop.os = "android";
  programs.ssh.userMatchBlocks = "nix-on-droid";
  programs.zsh.shellAliases = lib.mkForce { shutdown = "exec shutdown"; };
  programs.zsh.oh-my-zsh.plugins = lib.mkForce [ "git" "ssh-agent" ];

  home.stateVersion = "24.05";
}
