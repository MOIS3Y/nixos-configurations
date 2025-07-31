# █░█ █▀ █▀▀ █▀█ █▀▄ █▀▀ ▀
# ▀▄▀ ▄█ █▄▄ █▄█ █▄▀ ██▄ ▄
# -- -- -- -- -- -- -- --

{ config, pkgs, lib, ... }: {
  # TODO: make it more declaratively
  programs.vscode = {
    enable = lib.mkDefault config.desktop.enable;
    mutableExtensionsDir = true;
  };
  #? Workaround missing cmd not found in $PATH
  #? see: https://discourse.nixos.org/t/vs-code-and-nix-ide-newbie-problems/51385
  home.packages = lib.optionals config.programs.vscode.enable [
    pkgs.nixpkgs-fmt
    pkgs.nixd
  ];
}
