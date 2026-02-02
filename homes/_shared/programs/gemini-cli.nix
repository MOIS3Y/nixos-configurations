# █▀▀ █▀▀ █▀▄▀█ █ █▄░█ █ ▄▄ █▀▀ █░░ █ ▀
# █▄█ ██▄ █░▀░█ █ █░▀█ █ ░░ █▄▄ █▄▄ █ ▄
# -- -- -- -- -- -- -- -- -- -- -- -- -

{ lib, ... }:
let
  rawDir = lib.path.append ../../.. "raw/gemini";
  readRaw = path: builtins.readFile (lib.path.append rawDir path);
  importCommand =
    path:
    (
      (
        { prompt, description, ... }:
        {
          inherit prompt description;
        }
      )
      (fromTOML (readRaw path))
    );
in
{
  programs.gemini-cli = {
    enable = true;
    settings = {
      general = {
        enableAutoUpdate = false;
        enablePromptCompletion = true;
        vimMode = false;  # not useful with RU keyboard layout
        checkpointing = {
          enable = true;
        };
      };
      security = {
        auth = {
          selectedType = "oauth-personal";
        };
      };
      ui = {
        hideTips = true;
        showLineNumbers = false;
        footer = {
          hideSandboxStatus = true;
          hideContextPercentage = false;
        };
      };
    };
    context = {
      GEMINI = readRaw "context/GEMINI.md";
    };
    commands = {
      # Education
      "edu-explain" = importCommand "commands/edu-explain.toml";
      # Git
      "git/commit-help" = importCommand "commands/git-commit-help.toml";
      "git/msg" = importCommand "commands/git-msg.toml";
      "git/refactor" = importCommand "commands/git-refactor.toml";
      "git/review" = importCommand "commands/git-review.toml";
      "git/squash" = importCommand "commands/git-squash.toml";
      "git/test" = importCommand "commands/git-test.toml";
    };
  };
}
