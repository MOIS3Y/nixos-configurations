# █▀▄ █▀▀ █░█ █▀▀ █░░ █▀█ █▀█ █▀▄▀█ █▀▀ █▄░█ ▀█▀ ▀
# █▄▀ ██▄ ▀▄▀ ██▄ █▄▄ █▄█ █▀▀ █░▀░█ ██▄ █░▀█ ░█░ ▄
# -- -- -- -- -- -

{ pkgs, ... }: {
  home.packages = with pkgs; [
    gettext
    gimp
    gnumake
    inkscape
    insomnia
    poetry
    sassc
    sqlitebrowser
    uv
    # Languages:
    (lua.withPackages(ps: with ps; [ luarocks ]))
    (python3.withPackages(ps: with ps; [ pip ]))
    # Rust env (for quick use without nix develop or shell)
    cargo
    rustc
    rustfmt
    clippy
    rust-analyzer
    # AI tools:
    opencode
  ];
}
