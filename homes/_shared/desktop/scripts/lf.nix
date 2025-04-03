# █░░ █▀▀ ▀
# █▄▄ █▀░ ▄
# -- -- -- 

{ config, pkgs, ... }: let
  inherit (config.desktop.utils)
    file
    kitty
    pistol
    xdragon;
  in {
  desktop.scripts.lf = {
    previewer =  pkgs.writeShellScript "lf-kitty-preview.sh" ''
      file=$1
      w=$2
      h=$3
      x=$4
      y=$5
      # ? intercepts the file and checks the type if img - is using kitty:
      if [[ "$( ${file} -Lb --mime-type "$file")" =~ ^image ]]; then
          ${kitty} \
            +kitten icat \
            --silent \
            --stdin no \
            --transfer-mode file \
            --place "''${w}x''${h}@''${x}x''${y}" "$file" < /dev/null > /dev/tty
          exit 1
      fi
      # ? otherwise uses pistol:
      ${pistol} "$file"
    '';
    cleaner = pkgs.writeShellScript "lf-kitty-clean.sh" ''
      ${kitty} \
        +kitten icat \
        --clear \
        --stdin no \
        --silent \
        --transfer-mode file < /dev/null > /dev/tty
    '';
    # commands:
    dragon-out = ''%${xdragon} -a -x "$fx"'';
  };
}
