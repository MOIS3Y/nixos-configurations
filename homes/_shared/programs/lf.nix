# █░░ █▀▀ ▀
# █▄▄ █▀░ ▄
# -- -- -- 

{ config, pkgs, ... }: let
  # pull icons file
  lfIcons = builtins.fetchurl rec {
    name = "lf-icons-${sha256}.txt";
    url = "https://raw.githubusercontent.com/gokcehan/lf/6cabb0e8e43c8a374fcb1e0d4225141f478ce212/etc/icons.example";
    sha256 = "12cwy6kfa2wj7nzffaxn5bka21yjqa5sx38nzdhyg1dq0c6jnjkk";
  };
in {
  programs.lf = {
    enable = true;
    settings = {
      drawbox = true;
      icons = true;
      ignorecase = true;
    };
    commands = with config.apps.scripts.lf; {
      inherit
      dragon-out
      editor-open
      mkdir;
    };
    keybindings = {
      xx = "dragon-out";
      mk = "mkdir";
      xD = "delete";
      "<enter>" = "open";
      # ... add more keybindings here:
    };
    extraConfig = with config.apps.scripts.lf; ''
      set cleaner ${cleaner}
      set previewer ${previewer}
      setlocal ${config.xdg.userDirs.pictures}/isp sortby 'time' 
    '';
  };
  xdg.configFile."lf/icons".source = lfIcons;  # enable icons
}
