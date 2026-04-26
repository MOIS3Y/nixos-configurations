# █▀▄ █▀▀ █░█ █▀▀ █░░ █▀█ █▀█ █▀▄▀█ █▀▀ █▄░█ ▀█▀ ▀
# █▄▀ ██▄ ▀▄▀ ██▄ █▄▄ █▄█ █▀▀ █░▀░█ ██▄ █░▀█ ░█░ ▄
# -- -- -- -- -- -

{ pkgs, ... }: {
  home.packages = with pkgs; [
    # Tools:
    gettext
    gimp
    gnumake
    inkscape
    insomnia
    sassc
    sqlitebrowser
    # Languages:
    nodejs_25
    (lua.withPackages(ps: with ps; [ luarocks ]))
    (python3.withPackages(ps: with ps; [ pip ]))
    poetry
    uv
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
