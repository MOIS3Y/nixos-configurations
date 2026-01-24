# █▄░█ █░█ █▀▀ █░█ ▄▀█ █▀▄ ▀
# █░▀█ ▀▄▀ █▄▄ █▀█ █▀█ █▄▀ ▄
# -- -- -- -- -- -- -- -- --

{ inputs, pkgs, lib, ... }: {
  imports = [
    inputs.nix4nvchad.homeManagerModule
  ];
  programs.nvchad = {
    enable = lib.mkDefault true;
    extraPackages = with pkgs; lib.mkDefault [
      # LSP servers
      nodePackages.bash-language-server
      blueprint-compiler
      docker-compose-language-service
      dockerfile-language-server
      emmet-language-server
      vscode-langservers-extracted
      rust-analyzer
      typescript-language-server
      vue-language-server
      vala-language-server
      nixd
      (python3.withPackages(ps: with ps; [
        python-lsp-server
        python-lsp-ruff
        flake8
      ]))
      # formatters
      nodePackages.prettier
      nixfmt
      rustfmt
      shfmt
    ];
    hm-activation = true;
    backup = false;
  };
}
