# █░█ █▀█ █▀▄▀█ █▀▀ ▄▄ █▀▄▀█ ▄▀█ █▄░█ ▄▀█ █▀▀ █▀▀ █▀█ ▀
# █▀█ █▄█ █░▀░█ ██▄ ░░ █░▀░█ █▀█ █░▀█ █▀█ █▄█ ██▄ █▀▄ ▄
# -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- --

{ osConfig, ... }: {
  imports = [
    # Custom modules:
    ../../modules/colors
    ../../modules/desktop
    ../../modules/programs
    # Shared configuration:
    ../_shared/config
    ../_shared/pkgs
    ../_shared/programs
    ../_shared/services
    ../_shared/sops
  ];

  home = {
    username = "stepan";
    homeDirectory = "/home/stepan";
  };

  # ? inherit host configuration
  colorSchemeName = osConfig.colorSchemeName;
  desktop = osConfig.desktop;

  # Override _shared configuration:
  sops = {
    defaultUserSopsFile = ../../secrets/homes/stepan/secrets.yaml;
    sharedSecrets = "stepan";  # ? override default secrets option
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
