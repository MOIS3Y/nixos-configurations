# █░░ █▀▀ ▀
# █▄▄ █▀░ ▄
# -- -- -- 

# ! Minimal general configuration.
# ! Extensions (previewer, dragon) are configured in desktop/programs/lf.nix

{ ... }: let
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
    commands = {
      editor-open = ''$$EDITOR $f'';
      mkdir = ''
        ''${{
          printf "Directory Name: "s
          read DIR
          mkdir $DIR
        }}
      '';
    };
    keybindings = {
      mk = "mkdir";
      xD = "delete";
      "<enter>" = "open";
      # ... add more keybindings here:
    };
  };
  xdg.configFile."lf/icons".source = lfIcons;  # enable icons
}
