# █░█ █▀█ █▀▄▀█ █▀▀ ▄▄ █▀▄▀█ ▄▀█ █▄░█ ▄▀█ █▀▀ █▀▀ █▀█ ▀
# █▀█ █▄█ █░▀░█ ██▄ ░░ █░▀░█ █▀█ █░▀█ █▀█ █▄█ ██▄ █▀▄ ▄
# -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- --

{ config, pkgs, ... }: {
  imports = [
    ../../modules/assets
    ../../modules/colors
    ../../modules/desktop
    
    ../_shared/desktop
    ../_shared/programs
    ../_shared/sops
  ];

  home = {
    username = "stepan";
    homeDirectory = "/home/stepan";
  };

  sops = {
    defaultUserSopsFile = ../../secrets/homes/stepan/secrets.yaml;
    sharedSecrets = "stepan";  # ? override default secrets option
  };

  desktop = {
    apps = with config.desktop.utils; {
      terminal = kitty;
      spare-terminal = wezterm;
      browser = firefox;
      filemanager = nautilus;
      launcher = wofi;
      lockscreen = hyprlock;
      visual-text-editor = vscode;
    };
  };

  programs.ssh.userMatchBlocks = "stepan";

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
