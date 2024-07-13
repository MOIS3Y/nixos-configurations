# █▀ █░█░█ ▄▀█ █▀█ █▀█ █▄█ ▀
# ▄█ ▀▄▀▄▀ █▀█ █▀▀ █▀▀ ░█░ ▄
# -- -- -- -- -- -- -- -- --

{ config, pkgs, lib, ... }: {
  options = {
    earlyExit = lib.mkOption {
      default = false;
      type = lib.types.bool;
      description = ''
        is used to make the application exit after saving the picture
        or copying it to the clipboard
      '';
    };
  };
  config = lib.mkIf config.desktop.wayland.enable {
    home.file."${config.xdg.configHome}/swappy/config".text = ''
      [Default]
      save_dir=${config.home.homeDirectory}/Pictures/Screenshots
      save_filename_format=%Y-%m-%d-%H-%M-%S.png
      show_panel=false
      line_size=3
      text_size=20
      text_font=sans-serif
      early_exit=${lib.trivial.boolToString config.earlyExit}
    '';
    home.packages = with pkgs; [
      grim
      slurp
      swappy
      wl-clipboard
    ];
  };
}
