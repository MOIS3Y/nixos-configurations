# █▀ █░█░█ ▄▀█ █▀█ █▀█ █▄█ ▀
# ▄█ ▀▄▀▄▀ █▀█ █▀▀ █▀▀ ░█░ ▄
# -- -- -- -- -- -- -- -- --

# From custom modules/programs/swappy.nix
# add import ../modules/programs into home.nix before use it.

{ config, pkgs, ... }: let
  cfg = config.desktop.wayland;
  in {
  programs.swappy = {
    enable = cfg.enable;
    package = pkgs.swappy;
    extraPackages = [
      pkgs.grim
      pkgs.slurp
      pkgs.wl-clipboard
    ];
    settings = {
      Default = {
        save_dir = "${config.home.homeDirectory}/Pictures/Screenshots";
        save_filename_format = "%Y-%m-%d-%H-%M-%S.png";
        show_panel = false;
        line_size = 3;
        text_size = 20;
        text_font = "sans-serif";
        early_exit = false;
      };
    };
  };
}
