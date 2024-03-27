# █▀▀ ▀█▀ █▄▀ ▀
# █▄█ ░█░ █░█ ▄
# -- -- -- -- -

{ config, pkgs, lib, ... }:
  let
    extraCss = ''
      @define-color accent_color #74c7ec;
      @define-color accent_bg_color #89b4fa;
      @define-color accent_fg_color #11111b;
      @define-color destructive_color #ee99a0;
      @define-color destructive_bg_color #ed8796;
      @define-color destructive_fg_color #11111b;
      @define-color success_color #a6da95;
      @define-color success_bg_color #8bd5ca;
      @define-color success_fg_color #11111b;
      @define-color warning_color #f5a97f;
      @define-color warning_bg_color #eed49f;
      @define-color warning_fg_color #11111b;
      @define-color error_color #ee99a0;
      @define-color error_bg_color #ed8796;
      @define-color error_fg_color #11111b;
      @define-color window_bg_color #1e1e2e;
      @define-color window_fg_color #cdd6f4;
      @define-color view_bg_color #11111b;
      @define-color view_fg_color #cdd6f4;
      @define-color headerbar_bg_color #11111b;
      @define-color headerbar_fg_color #cdd6f4;
      @define-color headerbar_border_color #313244;
      @define-color headerbar_backdrop_color @window_bg_color;
      @define-color headerbar_shade_color rgba(0, 0, 0, 0.36);
      @define-color card_bg_color #181825;
      @define-color card_fg_color #cdd6f4;
      @define-color card_shade_color rgba(0, 0, 0, 0.36);
      @define-color dialog_bg_color #181825;
      @define-color dialog_fg_color #cdd6f4;
      @define-color popover_bg_color #181825;
      @define-color popover_fg_color #cdd6f4;
      @define-color shade_color rgba(0,0,0,0.36);
      @define-color scrollbar_outline_color rgba(0,0,0,0.5);
      @define-color sidebar_bg_color #1e1e2e;
      @define-color sidebar_fg_color #cdd6f4;
      @define-color sidebar_backdrop_color #1e1e2e;
      @define-color blue_1 #99c1f1;
      @define-color blue_2 #62a0ea;
      @define-color blue_3 #3584e4;
      @define-color blue_4 #1c71d8;
      @define-color blue_5 #1a5fb4;
      @define-color green_1 #8ff0a4;
      @define-color green_2 #57e389;
      @define-color green_3 #33d17a;
      @define-color green_4 #2ec27e;
      @define-color green_5 #26a269;
      @define-color yellow_1 #f9f06b;
      @define-color yellow_2 #f8e45c;
      @define-color yellow_3 #f6d32d;
      @define-color yellow_4 #f5c211;
      @define-color yellow_5 #e5a50a;
      @define-color orange_1 #ffbe6f;
      @define-color orange_2 #ffa348;
      @define-color orange_3 #ff7800;
      @define-color orange_4 #e66100;
      @define-color orange_5 #c64600;
      @define-color red_1 #f66151;
      @define-color red_2 #ed333b;
      @define-color red_3 #e01b24;
      @define-color red_4 #c01c28;
      @define-color red_5 #a51d2d;
      @define-color purple_1 #dc8add;
      @define-color purple_2 #c061cb;
      @define-color purple_3 #9141ac;
      @define-color purple_4 #813d9c;
      @define-color purple_5 #613583;
      @define-color brown_1 #cdab8f;
      @define-color brown_2 #b5835a;
      @define-color brown_3 #986a44;
      @define-color brown_4 #865e3c;
      @define-color brown_5 #63452c;
      @define-color light_1 #ffffff;
      @define-color light_2 #f6f5f4;
      @define-color light_3 #deddda;
      @define-color light_4 #c0bfbc;
      @define-color light_5 #9a9996;
      @define-color dark_1 #77767b;
      @define-color dark_2 #5e5c64;
      @define-color dark_3 #3d3846;
      @define-color dark_4 #241f31;
      @define-color dark_5 #000000;
    '';
    gtk4css = pkgs.writeTextFile {
      name = "gtk.css";
      text = "${extraCss}";
    };
  in {
  gtk = {
    enable = true;
    
    theme = {
      name = "adw-gtk3";
      package = pkgs.adw-gtk3;
    };
    iconTheme = {
      name = "Tela-circle-blue-dark";
      package = pkgs.tela-circle-icon-theme.override {
        allColorVariants = true;
      };
    };
    font = {
      name = "Ubuntu";
      package = pkgs.ubuntu_font_family;
      size = 11;
    };
    gtk3 = {
      extraConfig = {
        gtk-decoration-layout = "menu:";
      };
      inherit extraCss; 
    };
    gtk4 = {
      extraConfig = {
        gtk-decoration-layout = "menu:";
      };
      inherit extraCss; 
    };
  };
  # ? workaround write custom gtk-4.0 css
  # ? see: https://github.com/nix-community/home-manager/issues/5133
  home.activation.removeGTK4Css = lib.hm.dag.entryBefore ["checkLinkTargets"] ''
    if [ -f "${config.xdg.configHome}/gtk-4.0/gtk.css" ]; then
      rm ${config.xdg.configHome}/gtk-4.0/gtk.css
    fi
  '';
  home.activation.linkGTK4Css = lib.hm.dag.entryAfter ["writeBoundary"] ''
    rm ${config.xdg.configHome}/gtk-4.0/gtk.css
    ln -s ${gtk4css} ${config.xdg.configHome}/gtk-4.0/gtk.css
  '';
}
