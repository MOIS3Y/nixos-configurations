# █░░ █▀▀ ▀
# █▄▄ █▀░ ▄
# -- -- -- 

{ config, pkgs, ... }:
  let
    # previewer and cleaner for preview files content:
    previewer = with pkgs; writeShellScriptBin "pv.sh" ''
      file=$1
      w=$2
      h=$3
      x=$4
      y=$5
      # ? intercepts the file and checks the type if img - is using kitty:
      if [[ "$( ${file}/bin/file -Lb --mime-type "$file")" =~ ^image ]]; then
          ${kitty}/bin/kitty \
            +kitten icat \
            --silent \
            --stdin no \
            --transfer-mode file \
            --place "''${w}x''${h}@''${x}x''${y}" "$file" < /dev/null > /dev/tty
          exit 1
      fi
      # ? otherwise uses pistol:
      ${pistol}/bin/pistol "$file"
    '';
    cleaner = with pkgs; writeShellScriptBin "clean.sh" ''
      ${kitty}/bin/kitty \
        +kitten icat \
        --clear \
        --stdin no \
        --silent \
        --transfer-mode file < /dev/null > /dev/tty
    '';
    # pull icons file
    lfIcons = builtins.fetchurl rec {
      name = "lf-icons-${sha256}.txt";
      url = "https://raw.githubusercontent.com/gokcehan/lf/master/etc/icons.example";
      sha256 = "0141nzyjr3mybkbn9p0wwv5l0d0scdc2r7pl8s1lgh11wi2l771x";
    };
  in {
  programs.lf = {
    enable = true;
    settings = {
      drawbox = true;
      icons = true;
      ignorecase = true;
    };
    commands = {
      dragon-out = ''%${pkgs.xdragon}/bin/xdragon -a -x "$fx"'';
      editor-open = ''$$EDITOR $f'';
      mkdir = ''
        ''${{
          printf "Directory Name: "
          read DIR
          mkdir $DIR
        }}
      '';
    };
    keybindings = {
      xx = "dragon-out";
      mk = "mkdir";
      xD = "delete";
      "<enter>" = "open";
      # ... add more keybindings here:
    };
    extraConfig = ''
      set cleaner ${cleaner}/bin/clean.sh
      set previewer ${previewer}/bin/pv.sh
      setlocal ${config.xdg.userDirs.pictures}/isp sortby 'time' 
    '';
  };
  xdg.configFile."lf/icons".source = lfIcons;  # enable icons
}
