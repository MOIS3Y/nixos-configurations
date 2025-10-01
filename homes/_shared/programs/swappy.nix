# █▀ █░█░█ ▄▀█ █▀█ █▀█ █▄█ ▀
# ▄█ ▀▄▀▄▀ █▀█ █▀▀ █▀▀ ░█░ ▄
# -- -- -- -- -- -- -- -- --

{ config, lib, ... }: {
  programs.swappy = {
    enable = lib.mkDefault config.desktop.wayland.enable;
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
