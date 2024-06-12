# █▀█ ▀█▀ ▀
# ▀▀█ ░█░ ▄
# -- -- -- 

{ config, pkgs, ... }:
  let
    qtConf = ''
      [Appearance]
        custom_palette=false
        icon_theme=Tela-circle-dark
        standard_dialogs=gtk3
        style=kvantum

        [Fonts]
        fixed="Ubuntu,12,-1,5,50,0,0,0,0,0"
        general="Ubuntu,12,-1,5,50,0,0,0,0,0"

        [Interface]
        activate_item_on_single_click=1
        buttonbox_layout=0
        cursor_flash_time=1000
        dialog_buttons_have_icons=1
        double_click_interval=400
        gui_effects=@Invalid()
        keyboard_scheme=2
        menus_have_icons=true
        show_shortcuts_in_context_menus=true
        stylesheets=@Invalid()
        toolbutton_style=4
        underline_shortcut=1
        wheel_scroll_lines=3

        [Troubleshooting]
        force_raster_widgets=1
        ignored_applications=@Invalid()  
  '';
  in {
  qt = {
    enable = true;
    platformTheme.name = "qtct";
    style.name = "kvantum";
  };
  # qt5ct
  xdg.configFile = {
    "qt5ct/qt5ct.conf".text = ''
      ${qtConf}
    '';
  # qt6ct
  };
  xdg.configFile = {
    "qt6ct/qt6ct.conf".text = ''
      ${qtConf}
    '';
  };
  # kvantum
  xdg.configFile = {
    "Kvantum/kvantum.kvconfig".text = ''
      [General]
      theme=ColloidNordDark
    '';
    "Kvantum/ColloidNord".source = "${pkgs.colloid-kde}/share/Kvantum/ColloidNord";
  };
}
