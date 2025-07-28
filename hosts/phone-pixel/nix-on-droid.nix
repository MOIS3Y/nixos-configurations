# █▄░█ █ ▀▄▀ ▄▄ █▀█ █▄░█ ▄▄ █▀▄ █▀█ █▀█ █ █▀▄ ▀
# █░▀█ █ █░█ ░░ █▄█ █░▀█ ░░ █▄▀ █▀▄ █▄█ █ █▄▀ ▄
# -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- 

# First configuration init by flake
# If you want to use nix-shell:
# nix-channel --add https://nixos.org/channels/nixpkgs-unstable nixpkgs
# nix-channel --update

{ pkgs, lib, home-config, ... }: {
  imports = [
    # Custom modules:
    ../../modules/colors
    ../../modules/android
  ];

  android-integration = {
    am.enable = true;
    termux-setup-storage.enable =true;
    termux-open.enable = true;
    termux-open-url.enable = true;
    termux-reload-settings.enable = true;
    xdg-open.enable = true;
  };

  home-manager = home-config;

  environment = {
    motd = null;
    etcBackupExtension = ".bak";
    packages = [];
  };

  nix = {
    extraOptions = ''
      experimental-features = nix-command flakes
    '';
  };

  services = {
    sshd = {
      enable = true;
      ports = [ 8022 ];
      authorizedKeys = [
        "ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAIHpqvGMqZyzWT6RRRJodwC1S/K4AjvlwAhmn9bC/8r6u nix-on-droid"
      ];
    };
  };

  programs = {
    shutdown = {
      enable = true;
      services = [
        "lf"
        "sshd"
        "ssh-agent"
      ];
    };
  };

  user.shell = "${lib.getExe pkgs.zsh}";

  time.timeZone = "Asia/Chita";

  system.stateVersion = "24.05";
}
