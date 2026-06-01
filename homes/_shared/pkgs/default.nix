# █░█ █▀ █▀▀ █▀█   █▀█ ▄▀█ █▀▀ █▄▀ ▄▀█ █▀▀ █▀▀ █▀ ▀
# █▄█ ▄█ ██▄ █▀▄   █▀▀ █▀█ █▄▄ █░█ █▀█ █▄█ ██▄ ▄█ ▄
# -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -
# Aggregates common user packages across various categories.

{ pkgs, ... }:
{
  imports = [
    ./scripts.nix
  ];

  home.packages = with pkgs; [
    # AI tools:
    opencode

    # Development Languages:
    (lua.withPackages (ps: with ps; [ luarocks ]))
    nodejs_26
    poetry
    (python3.withPackages (ps: with ps; [ pip ]))
    uv

    # Development Rust Env (for quick use without nix develop or shell):
    cargo
    clippy
    rust-analyzer
    rustc
    rustfmt

    # Development Tools:
    gettext
    gimp
    gnumake
    inkscape
    insomnia
    sassc
    sqlitebrowser

    # Media:
    amberol
    cassette
    celluloid
    delfin
    feishin
    imv
    shotwell
    transmission_4-gtk
    tremotesf
    vlc

    # Network:
    google-chrome
    system-config-printer
    wireguard-tools

    # Security:
    age
    sops
    totp-cli

    # Society / Communication:
    mattermost-desktop
    telegram-desktop

    # Wine:
    wine
    winetricks
  ];
}
