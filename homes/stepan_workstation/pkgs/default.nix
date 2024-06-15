# █▀█ █▄▀ █▀▀ █▀ ▀
# █▀▀ █░█ █▄█ ▄█ ▄
# -- -- -- -- -- -

{ config, pkgs, ... }: {
  home.packages = with pkgs; [
    # Default:
    arandr
    amdgpu_top
    amberol
    celluloid
    eww  # TODO: enable in programs after configure
    firefox
    flameshot
    gimp
    gnumake
    gradience
    inkscape
    linphone
    (lutris.override {
      extraPkgs = pkgs: with pkgs; [
        winePackages.unstableFull
      ];
    })
    mattermost-desktop
    poetry
    protonup-qt
    pulseaudio
    ripgrep
    rofi-bluetooth
    rofi-power-menu
    rofi-systemd
    rofi-vpn
    sassc
    sqlitebrowser
    telegram-desktop
    transmission-gtk
    vault 
    vlc
    vscode
    vrrtest
    wine
    winetricks
    wireguard-tools
    wireplumber
    xwaylandvideobridge
    zoom-us
    # Extra-pkgs:
    extrapkgs.aladdin4nix
    extrapkgs.i3lock-run
    extrapkgs.xidlehook-caffeine
  ];
}
