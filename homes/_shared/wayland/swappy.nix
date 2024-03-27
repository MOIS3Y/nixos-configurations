# █▀ █░█░█ ▄▀█ █▀█ █▀█ █▄█ ▀
# ▄█ ▀▄▀▄▀ █▀█ █▀▀ █▀▀ ░█░ ▄
# -- -- -- -- -- -- -- -- --

{ config, pkgs, lib, ... }:
  let
    homeDir = "${config.home.homeDirectory}";
    xdgConf = "${config.xdg.configHome}";
    boolToString = lib.trivial.boolToString;
  in {
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
  config = {
    home.file."${xdgConf}/swappy/config".text = ''
      [Default]
      save_dir=${homeDir}/Pictures/Screenshots
      save_filename_format=%Y-%m-%d-%H-%M-%S.png
      show_panel=false
      line_size=3
      text_size=20
      text_font=sans-serif
      early_exit=${boolToString config.earlyExit}
    '';
    home.packages = with pkgs; [
      grim
      slurp
      swappy
      wl-clipboard
    ];
  };
}
