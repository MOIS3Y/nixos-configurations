# █▀▀ ▀█▀ █▄▀ ▀
# █▄█ ░█░ █░█ ▄
# -- -- -- -- -

{ config, pkgs, lib, ... }: let
  inherit (config.colorScheme)
    palette
    variant;
  extraCss = with palette; ''
    @define-color accent_color #${base0E};
    @define-color accent_bg_color#${base0D};
    @define-color accent_fg_color #${base00};
    @define-color destructive_color #${base00};
    @define-color destructive_bg_color #${base08};
    @define-color destructive_fg_color #${base00};
    @define-color success_color #${base0B};
    @define-color success_bg_color #${base0C};
    @define-color success_fg_color #${base00};
    @define-color warning_color #${base09};
    @define-color warning_bg_color #${base0A};
    @define-color warning_fg_color #${base00};
    @define-color error_color #${base08};
    @define-color error_bg_color #${base08};
    @define-color error_fg_color #${base00};
    @define-color window_bg_color #${base01};
    @define-color window_fg_color #${base05};
    @define-color view_bg_color #${base00};
    @define-color view_fg_color #${base05};
    @define-color headerbar_bg_color #${base00};
    @define-color headerbar_fg_color #${base05};
    @define-color headerbar_border_color #${base03};
    @define-color headerbar_backdrop_color @window_bg_color;
    @define-color headerbar_shade_color rgba(0, 0, 0, 0.36);
    @define-color card_bg_color #${base00};
    @define-color card_fg_color #${base05};
    @define-color card_shade_color rgba(0, 0, 0, 0.36);
    @define-color dialog_bg_color #${base00};
    @define-color dialog_fg_color #${base05};
    @define-color popover_bg_color #${base00};
    @define-color popover_fg_color #${base05};
    @define-color shade_color rgba(0,0,0,0.36);
    @define-color scrollbar_outline_color rgba(0,0,0,0.5);
    @define-color sidebar_bg_color #${base01};
    @define-color sidebar_fg_color #${base05};
    @define-color sidebar_backdrop_color #${base01};
  '';
  commonGtkExtraConfig = {
    gtk-decoration-layout = "menu:";
    # add more common gtk3/4 settings here ...
  };
  in {
  gtk = {
    enable = true;    
    theme = {
      name = ''${ if variant == "dark" then "adw-gtk3-dark" else "adw-gtk3" }'';
      package = pkgs.adw-gtk3;
    };
    iconTheme = {
      name = ''${if variant == "dark" then "Tela-circle-dark" else "Tela-circle-light"}'';
      package = pkgs.tela-circle-icon-theme;
    };
    font = {
      name = "Ubuntu";
      package = pkgs.ubuntu-classic;
      size = 11;
    };
    gtk3 = {
      extraConfig = commonGtkExtraConfig // lib.optionalAttrs (variant == "dark") {
        gtk-application-prefer-dark-theme = true;
      };
      inherit extraCss;
    };
    gtk4 = {
      extraConfig = commonGtkExtraConfig;
      inherit extraCss;
    };
  };
}
