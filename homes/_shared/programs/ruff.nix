# █▀█ █░█ █▀▀ █▀▀ ▀
# █▀▄ █▄█ █▀░ █▀░ ▄
# -- -- -- -- -- --

{ lib, ... }: {
  programs.ruff = {
    enable = lib.mkDefault true;
    # If left unspecified, Ruff's default configuration is equivalent to
    # https://docs.astral.sh/ruff/configuration/
    settings = {
      line-length = 79;  # default 88
      lint = {
        select = [
          "E"    # pycodestyle
          "F"    # Pyflakes
          "UP"   # pyupgrade
          "B"    # flake8-bugbear
          "SIM"  # flake8-simplify
          "I"    # isort
        ];
        per-file-ignores = {
          "__init__.py" = [ "E402" ];
          "**/{tests,docs,tools}/*" = [ "E402" ];
        };
      };
    };
  };
}