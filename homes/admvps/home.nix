# █░█ █▀█ █▀▄▀█ █▀▀ ▄▄ █▀▄▀█ ▄▀█ █▄░█ ▄▀█ █▀▀ █▀▀ █▀█ ▀
# █▀█ █▄█ █░▀░█ ██▄ ░░ █░▀░█ █▀█ █░▀█ █▀█ █▄█ ██▄ █▀▄ ▄
# -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- --

{ pkgs, lib, ... }: {
  imports = [
    # Custom modules:
    ../../modules/colors
    # Shared configuration:
    ../_shared/programs/git.nix
    ../_shared/programs/htop.nix
    ../_shared/programs/lf.nix
    ../_shared/programs/lsd.nix
    ../_shared/programs/nvchad.nix
    ../_shared/programs/zsh.nix
  ];
  # Override _shared configuration:
  home = {
    username = "admvps";
    homeDirectory = "/home/admvps";
  };

  programs.nvchad.extraPackages = with pkgs; lib.mkForce [
    nodePackages.bash-language-server
    docker-compose-language-service
    nixd
  ];

  # Let Home Manager install and manage itself.
  programs.home-manager.enable = true;

  # This value determines the Home Manager release that your
  # configuration is compatible with. This helps avoid breakage
  # when a new Home Manager release introduces backwards
  # incompatible changes.
  #
  # You can update Home Manager without changing this value. See
  # the Home Manager release notes for a list of state version
  # changes in each release.
  home.stateVersion = "23.05";
}
