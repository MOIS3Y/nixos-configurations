# █▀█ █ █▀▀ █▀█ █▀▄▀█ ▀
# █▀▀ █ █▄▄ █▄█ █░▀░█ ▄
# -- -- -- -- -- -- -- 

{ config, pkgs, lib, ... }: lib.mkIf config.desktop.xorg.enable {
  services.picom = {
    enable = true;
    backend = "glx";
    vSync = true;

    shadow = true;
    shadowOffsets = [(-40) (-20)];
    shadowOpacity = 0.55;
    shadowExclude = [
      "class_g = 'Conky'"
      "class_g = 'slop'"
      "window_type = 'combo'"
      "window_type = 'desktop'"
      "window_type = 'dnd'"
      "window_type = 'dock'"
      "window_type = 'dropdown_menu'"
      "window_type = 'menu'"
      "window_type = 'notification'"
      "window_type = 'popup_menu'"
      "window_type = 'splash'"
      "window_type = 'toolbar'"
      "window_type = 'utility'"
    ];

    fade = true;
    fadeDelta = 10;
    fadeSteps = [0.03 0.03];
    fadeExclude = [
      "window_type = 'combo'"
      "window_type = 'desktop'"
      "window_type = 'dock'"
      "window_type = 'dnd'"
      "window_type = 'notification'"
      "window_type = 'toolbar'"
      "window_type = 'unknown'"
      "window_type = 'utility'"
    ];

    activeOpacity = 1.0;
    inactiveOpacity = 1.0;
    menuOpacity = 1.0;
    opacityRules = [
      "70:class_g = 'splash'"
      "100:class_g = 'org.wezfurlong.wezterm' && focused"
      "60:class_g = 'org.wezfurlong.wezterm' && !focused"
      "100:class_g = 'Alacritty' && focused"
      "60:class_g = 'Alacritty' && !focused"
    ];

    wintypes = {
      tooltip = {
        fade = true;
        shadow = true;
        focus = true;
        full-shadow = true;
      };
      dock = {shadow = false;};
      dnd = {shadow = false;};
      popup_menu = {opacity = 1;};
      dropdown_menu = {opacity = 1;};
      desktop = {full-shadow = false;};
      normal = {full-shadow = false;};
    };

    settings = {
      shadow-radius = 40;
      shadow-color = "#000000";
      shadow-ignore-shaped = false;

      frame-opacity = 1.0;
      inactive-opacity-override = false;
      focus-exclude = [
        "class_g = 'Cairo-clock'"
        "class_g = 'Peek'"
        "class_g = 'slop'"
        "window_type = 'combo'"
        "window_type = 'desktop'"
        "window_type = 'dialog'"
        "window_type = 'dnd'"
        "window_type = 'dock'"
        "window_type = 'dropdown_menu'"
        "window_type = 'menu'"
        "window_type = 'tooltip'"
        "window_type = 'unknown'"
        "window_type = 'utility'"
      ];

      corner-radius = 12;
      rounded-corners-exclude = [
        "window_type = 'dock'"
      ];

      blur-method = "dual_kawase";
      blur-kernel = "11x11gaussian";
      blur-deviation = 1.0;
      blur-strength = 10;
      blur-background = true;
      blur-background-frame = true;
      blur-background-fixed = true;
      blur-background-exclude = [
        "window_type = 'combo'"
        "window_type = 'desktop'"
        "window_type = 'dnd'"
        "window_type = 'menu'"
        "window_type = 'toolbar'"
        "window_type = 'tooltip'"
        "window_type = 'utility'"
        "window_type = 'unknown'"
        "window_type = 'dropdown_menu'"  # fix kvantum borders
        "window_type = 'popup_menu'"     # fix kvantum borders
        "class_g = 'firefox' && window_type != 'normal'"
        "class_g = 'slop'"
      ];

      mark-wmwin-focused = true;
      mark-ovredir-focused = true;
      detect-rounded-corners = true;
      detect-client-opacity = true;
      detect-transient = true;
      detect-client-leader = true;
      glx-no-stencil = true;
      use-damage = true;
      transparent-clipping = false;
      unredir-if-possible = false;
      log-level = "warn";
    };
  };
  # override systemd unit:
  systemd.user.services.picom.Service.Restart = lib.mkForce "always";
  systemd.user.services.picom.Service.RestartSec = lib.mkForce 90;
  systemd.user.services.picom.Service.ExecCondition = lib.mkForce [
    "${lib.getExe pkgs.bash} -c '! [ -v WAYLAND_DISPLAY ] || exit -1'"
  ];
  # override systemd-xdg-autostart-generator:
  # ? it's a hack, we don't need to autostart app-picom, we start it by .service
  xdg.configFile = {
  "autostart/picom.desktop".text = (
    builtins.readFile "${pkgs.picom}/etc/xdg/autostart/picom.desktop"
    ) + ''
      Hidden=true
    '';
  };
}
