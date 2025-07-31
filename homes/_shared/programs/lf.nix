# █░░ █▀▀ ▀
# █▄▄ █▀░ ▄
# -- -- -- 

{ config, lib, ... }: let
  # pull icons file
  lfIcons = builtins.fetchurl rec {
    name = "lf-icons-${sha256}.txt";
    url = "https://raw.githubusercontent.com/gokcehan/lf/6cabb0e8e43c8a374fcb1e0d4225141f478ce212/etc/icons.example";
    sha256 = "12cwy6kfa2wj7nzffaxn5bka21yjqa5sx38nzdhyg1dq0c6jnjkk";
  };
in {
  programs.lf = {
    enable = lib.mkDefault true;
    settings = {
      drawbox = true;
      icons = true;
      ignorecase = true;
    };
    commands = {
      editor-open = ''$$EDITOR $f'';
      mkdir = ''
        ''${{
          printf "Directory Name: "s
          read DIR
          mkdir $DIR
        }}
      '';
    } // lib.optionalAttrs (config.desktop.scripts.lf or null != null) {
      dragon-out = config.desktop.scripts.lf.dragon-out;
    };
    keybindings = {
      mk = "mkdir";
      xD = "delete";
      "<enter>" = "open";
      # ... add more common keybindings here:
    } // lib.optionalAttrs (config.desktop or null != null) {
      xx = "dragon-out";
      # ... add more desktop keybindings here:
    };
  } // lib.optionalAttrs (config.desktop.scripts.lf or null != null) {
    extraConfig = with config.desktop.scripts.lf; ''
      set cleaner ${cleaner}
      set previewer ${previewer}
      setlocal ${config.xdg.userDirs.pictures}/isp sortby 'time'
    '';
  };
  xdg.configFile."lf/icons".source = lfIcons;  # enable icons
}
