# █░░ █▀▀   █▀▀ ▀▄▀ ▀█▀ █▀▀ █▄░█ █▀▄ █▀▀ █▀▄ ▀
# █▄▄ █▀░   ██▄ █░█ ░█░ ██▄ █░▀█ █▄▀ ██▄ █▄▀ ▄
# -- -- -- -- -- -- -- -- -- -- -- -- -- -- --

{ config, lib, ... }: {
  programs.lf = {
    enable = lib.mkForce true;
    settings = lib.mkForce {
      drawbox = true;
      icons = true;
      ignorecase = true;
    };
    commands = with config.desktop.scripts.lf; {
      inherit dragon-out;
    };
    keybindings = {
      xx = "dragon-out";
      # ... add more extra keybindings here:
    };
    extraConfig = with config.desktop.scripts.lf; ''
      set cleaner ${cleaner}
      set previewer ${previewer}
      setlocal ${config.xdg.userDirs.pictures}/isp sortby 'time' 
    '';
  };
}
