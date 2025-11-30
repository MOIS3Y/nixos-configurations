# █▀ █▄█ █▀ ▀█▀ █▀▀ █▀▄▀█   █▀█ ▄▀█ █▀▀ █▄▀ ▄▀█ █▀▀ █▀▀ █▀ ▀
# ▄█ ░█░ ▄█ ░█░ ██▄ █░▀░█   █▀▀ █▀█ █▄▄ █░█ █▀█ █▄█ ██▄ ▄█ ▄
# -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -

{ config, pkgs, lib, ... }: let
  inherit (config.colorScheme)
    palette;
  inherit (config.desktop)
    assets
    cursor
    games;
  inherit (config.host)
    hardware
    virtualisation;
in {
  environment.systemPackages = with pkgs; [
    # common:
    bottom
    cmatrix
    curl
    dnsutils
    docker-compose
    git
    htop
    jq
    lm_sensors
    ncdu
    neofetch
    nitch
    nmap
    ntfs3g
    parted
    rsync
    ripgrep
    tree
    tty-clock
    wget
    unzip
  ]
  # optional:
  ++ lib.optionals config.desktop.enable [
    appimage-run
    at-spi2-atk         # !required for polkit-gnome-authentication-agent-1
    adwaita-icon-theme  #! required for most gnome apps
    evince
    file-roller
    firefox
    gnome-calculator
    gnome-calendar
    gnome-online-accounts-gtk
    libnotify
    nautilus
    pavucontrol
    xdg-utils
  ]
  ++ lib.optionals config.desktop.wayland.enable [
    # ? see: https://github.com/NixOS/nixpkgs/issues/280041
    swayosd  # ! required for SwayOSD LibInput Backend
  ]
  ++ lib.optionals config.services.desktopManager.gnome.enable [
    dconf-editor
    gnomeExtensions.auto-move-windows
    gnomeExtensions.appindicator
    gnomeExtensions.caffeine
    gnomeExtensions.system-monitor
    gnomeExtensions.useless-gaps
  ]
  ++ lib.optionals (config.desktop.enable && games.enable) games.extraPackages
  ++ lib.optionals (config.desktop.enable && hardware.gpu.enable) [
    amdgpu_top
    lact
    nvtopPackages.amd
  ]
  ++ lib.optionals (config.desktop.enable && virtualisation.libvirtd.enable) [
    virt-manager
  ]
  ++ lib.optionals (config.services.displayManager.sddm.enable) [
    cursor.package
    (pkgs.sddm-astronaut.override {
      themeConfig = {
        #################### General ####################
        ScreenWidth = 1920;
        ScreenHeight = 1080;
        KeyboardSize = 0.4;
        RoundCorners = 20;
        HourFormat="HH:mm";
        DateFormat = "dddd d MMMM yyyy";
        HeaderText = "NixOS";

        #################### Background ####################
        Background = "${assets.images.background}";

        #################### Colors ####################
        HeaderTextColor = "#${palette.base05}";
        DateTextColor = "#${palette.base05}";
        TimeTextColor = "#${palette.base05}";

        FormBackgroundColor = "#${palette.base01}";
        BackgroundColor = "#${palette.base01}";
        DimBackgroundColor = "#${palette.base00}";

        LoginFieldBackgroundColor = "#${palette.base02}";
        PasswordFieldBackgroundColor = "#${palette.base02}";
        LoginFieldTextColor = "#${palette.base05}";
        PasswordFieldTextColor = "#${palette.base05}";
        UserIconColor = "#${palette.base05}";
        PasswordIconColor = "#${palette.base05}";

        PlaceholderTextColor = "#${palette.base03}";
        WarningColor = "#${palette.base0A}";

        LoginButtonTextColor = "#${palette.base05}";
        LoginButtonBackgroundColor = "#${palette.base02}";
        SystemButtonsIconsColor = "#${palette.base05}";
        SessionButtonTextColor = "#${palette.base05}";
        VirtualKeyboardButtonTextColor = "#${palette.base05}";

        DropdownTextColor = "#${palette.base05}";
        DropdownSelectedBackgroundColor = "#${palette.base02}";
        DropdownBackgroundColor = "#${palette.base01}";

        HighlightTextColor = "#${palette.base06}";
        HighlightBackgroundColor = "#${palette.base03}";
        HighlightBorderColor = "#${palette.base03}";

        HoverUserIconColor = "#${palette.base0D}";
        HoverPasswordIconColor = "#${palette.base0D}";
        HoverSystemButtonsIconsColor = "#${palette.base0D}";
        HoverSessionButtonTextColor = "#${palette.base0D}";
        HoverVirtualKeyboardButtonTextColor = "#${palette.base0D}";

        #################### Form ####################
        PartialBlur = false;
        FullBlur = true;
        BlurMax = 64;
        Blur = 1.0;
        FormPosition = "center";

        #################### Interface Behavior ####################
        HideVirtualKeyboard = true;
      };
    })
  ];
}
