# █░█ █▀ █▀▀ █▀█ █▀▄ █▀▀ ▀
# ▀▄▀ ▄█ █▄▄ █▄█ █▄▀ ██▄ ▄
# -- -- -- -- -- -- -- --

{ pkgs, ... }: {
  # TODO: make it more declaratively
  programs.vscode = {
    enable = true;
    mutableExtensionsDir = true;
  };
  #? Workaround missing cmd not found in $PATH
  #? see: https://discourse.nixos.org/t/vs-code-and-nix-ide-newbie-problems/51385
  home.packages = with pkgs; [
    nixpkgs-fmt
    nixd
  ];
}
