# █░█ █▀█ █▀▄▀█ █▀▀ ▄▄ █▀▄▀█ ▄▀█ █▄░█ ▄▀█ █▀▀ █▀▀ █▀█ ▀
# █▀█ █▄█ █░▀░█ ██▄ ░░ █░▀░█ █▀█ █░▀█ █▀█ █▄█ ██▄ █▀▄ ▄
# -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- --

{ config, pkgs, lib, ... }: {
  imports = [
    ../../modules/colors
    ../_shared/programs
  ];
  # Override _shared configuration:
  home = {
    username = "admserv";
    homeDirectory = "/home/admserv";
  };

  programs = with lib; {
    helix.enable = mkForce false;
    khal.enable = mkForce false;
    lf.enable = mkForce false;
    nvchad.enable = mkForce false;
    ssh.enable = mkForce false;
  };

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
