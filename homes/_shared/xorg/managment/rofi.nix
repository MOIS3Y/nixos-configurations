# █▀█ █▀█ █▀▀ █ ▀
# █▀▄ █▄█ █▀░ █ ▄
# -- -- -- -- -- 

{ config, pkgs, ... }: {
  programs.rofi = {
    enable = true;
    plugins = with pkgs; [
      rofi-calc
      rofi-emoji
    ];
    terminal = "${config.apps.terminal}";
    location = "center";
    theme = let 
      inherit (config.lib.formats.rasi) mkLiteral; 
    in with config.colorScheme.palette; {
        "*" = {
          bg-col = mkLiteral "#${base00}" ;
          bg-col-light = mkLiteral "#${base00}" ;
          border-col = mkLiteral "#${base00}" ;
          selected-col = mkLiteral "#${base00}" ;
          accent = mkLiteral "#${base0D}" ;
          fg-col = mkLiteral "#${base05}" ;
          fg-col2 = mkLiteral "#${base0D}" ;
          grey = mkLiteral "#${base03}" ;
        };
        "element-text, element-icon , mode-switcher" = {
            background-color = mkLiteral "inherit";
            text-color = mkLiteral "inherit";
        };
        window = {
          height = mkLiteral "360px";
          width = mkLiteral "720px";
          border = mkLiteral "1px";
          border-color = mkLiteral "@border-col";
          background-color = mkLiteral "@bg-col";
        };
        mainbox = {
          background-color = mkLiteral "@bg-col";
        };
        inputbar = {
          children = map mkLiteral [ "prompt" "entry" ];
          background-color = mkLiteral "@bg-col";
          border-radius = mkLiteral "5px";
          padding = mkLiteral "2px";
        };
        prompt = {
            background-color = mkLiteral "@accent";
            padding = mkLiteral "6px";
            text-color = mkLiteral "@bg-col";
            border-radius = mkLiteral "3px";
            margin = mkLiteral "20px 0px 0px 20px";
        };
        textbox-prompt-colon = {
            expand = false;
            str = ":";
        };
        entry = {
            padding = mkLiteral "6px";
            margin = mkLiteral "20px 0px 0px 10px";
            text-color = mkLiteral "@fg-col";
            background-color = mkLiteral "@bg-col";
        };
        listview = {
            border = mkLiteral "0px 0px 0px";
            padding = mkLiteral "6px 0px 0px";
            margin = mkLiteral "10px 0px 0px 20px";
            columns = 2;
            background-color = mkLiteral "@bg-col";
        };
        element = {
            padding = mkLiteral "5px";
            background-color = mkLiteral "@bg-col" ;
            text-color = mkLiteral "@fg-col";
        };
        element-icon = {
            size = mkLiteral "25px";
        };
        "element selected" = {
            background-color = mkLiteral "@selected-col";
            text-color = mkLiteral "@fg-col2";
        };
        mode-switcher = {
            spacing = 0;
          };
        button = {
            padding = mkLiteral"10px";
            background-color = mkLiteral "@bg-col-light";
            text-color = mkLiteral "@grey";
            vertical-align = "0.5"; 
            horizontal-align = "0.5";
        };
        "button selected" = {
          background-color = mkLiteral "@bg-col";
          text-color = mkLiteral "@accent";
        };
    };
    extraConfig = {
      modi = "run,drun,ssh,window";
      lines = 5;
      font = "JetBrains Mono Nerd Font 12";
      show-icons = true;
      icon-theme = "${config.gtk.iconTheme.name}";
      drun-display-format = "{icon} {name}";
      location = 0;
      disable-history = false;
      hide-scrollbar = false;
      display-run = "   CMD ";
      display-drun = "   APPS ";
      display-ssh = "   SSH ";
      display-window = " 󰨇  WINDOW ";
      sidebar-mode = true;
    };
  };
  home.packages = with pkgs; [
    rofi-bluetooth
    rofi-power-menu
    rofi-systemd
    rofi-vpn
  ];
}
