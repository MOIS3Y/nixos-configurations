# █▀▀ █ ▀█▀ ▀
# █▄█ █ ░█░ ▄
# -- -- -- --

{ lib, ... }: {
  programs.git = {
    enable = lib.mkDefault true;
    signing = {
      format = "openpgp";
      key = "F40E8485FB87A653";
      signByDefault = true;
    };
    ignores = [
      # -- Nix & Direnv --
      "result"
      "result-*"
      ".direnv/"

      # -- Neovim / Vim --
      "*.swp"
      "*.swo"
      "undo/"
      ".netrwhist"
      "Session.vim"

      # -- Helix --
      ".helix/config.toml"
      ".helix/ignore"

      # -- VS Code --
      ".vscode/*"
      "!.vscode/extensions.json"
      "!.vscode/launch.json"
      "!.vscode/settings.json"
      "*.code-workspace"

      # -- Zed --
      ".zed/"
      ".zed-settings.json"

      # -- Gemini CLI & AI Context --
      "/GEMINI.md"
      ".geminiignore"
      ".gemini/"
    ];
    settings = {
      core.editor = "nvim";
      user = {
        name = "MOIS3Y";
        email = "stepan@zhukovsky.me";
      };
    };
  };
}
