# █▀█ █▀█ █▀█ █▀▀ █▀█ ▄▀█ █▀▄▀█ █▀ ▀
# █▀▀ █▀▄ █▄█ █▄█ █▀▄ █▀█ █░▀░█ ▄█ ▄
# -- -- -- -- -- -- -- -- -- -- -- -

{ config, pkgs, ... }: {
  imports = [
    # ../../_shared/programs/alacritty.nix
    ../../_shared/programs/eww.nix
    ../../_shared/programs/git.nix
    ../../_shared/programs/helix.nix
    ../../_shared/programs/khal.nix
    ../../_shared/programs/lf.nix
    ../../_shared/programs/lsd.nix
    ../../_shared/programs/mangohud.nix
    ../../_shared/programs/nvchad.nix
    ../../_shared/programs/ssh.nix
    ../../_shared/programs/wezterm.nix
    ../../_shared/programs/zsh.nix
  ];
}
