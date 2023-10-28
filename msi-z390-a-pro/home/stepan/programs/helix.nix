# █░█ █▀▀ █░░ █ ▀▄▀ ▀
# █▀█ ██▄ █▄▄ █ █░█ ▄
# -- -- -- -- -- -- -

{ config, pkgs, ... }: {
  programs.helix = {
    enable = true;
    extraPackages = with pkgs; [
      lua-language-server
      marksman
      nodePackages.bash-language-server
      vscode-langservers-extracted
    ];
    themes = {
      catppuccin_mocha_transparent = {
        inherits = "catppuccin_mocha";
        "ui.background" = {};
      };
    };
    settings = {
      theme = "catppuccin_mocha_transparent";
      editor = {
        scrolloff = 5;
        mouse = true;
        middle-click-paste = true;
        scroll-lines = 3;
        shell = [ "zsh" "-c" ];
        line-number = "absolute";
        cursorline = false;
        cursorcolumn = false;
        gutters = [ "diagnostics"  "spacer" "line-numbers" "spacer" "diff" ];
        auto-completion = true;
        auto-format = true;
        auto-save = false;
        idle-timeout = 400;
        completion-trigger-len = 2;
        completion-replace = false;
        auto-info = true;
        true-color = false;
        undercurl = false;
        rulers = [ 80 ];
        bufferline = "multiple";
        color-modes = true;
        statusline = {
          left = [ "mode" "spinner" ];
          center = [ "file-base-name" ];
          right = [
              "diagnostics"
              "version-control"
              "selections"
              "position"
              "total-line-numbers"
              "separator"
              "file-line-ending"
              "separator"
              "file-encoding"
              "file-type"
          ];
          separator = "│";
          mode.normal = "NORMAL";
          mode.insert = "INSERT";
          mode.select = "SELECT";
        };
        cursor-shape = {
          normal = "block";
          insert = "bar";
          select = "underline";
        };
        whitespace = {
          render = {
            tab = "all";
            newline = "none";
          };
          characters = {
            space = "·";
            nbsp = "⍽";
            tab = "→";
            newline = "⏎";
            tabpad = "·";  # Tabs will look like "→···" (depending on tab width)
          };
        };
        indent-guides = {
          render = true;
          character = "┊";  # Some characters that work well: "▏", "┆", "┊", "⸽"
          skip-levels = 1;
        };
      };
    };
    languages = {
      language = [
        {
          name = "nix";
          scope = "source.nix";
          injection-regex = "nix";
          file-types = [ "nix" ];
          shebangs = [ ];
          roots = [ ];
          comment-token = "#";
          indent = { tab-width = 2; unit = "  "; };
          auto-format = false;
          language-server = {
            name = "nil";
            command = "${pkgs.nil}/bin/nil";
            config.nix = {};
          };
        }
        {
          name = "python";
          scope = "source.python";
          injection-regex = "python";
          file-types = [ "py" ];
          shebangs = [ "python" "python3" ];
          roots = [ "pyproject.toml" "setup.py" "poetry.lock" ".git" ];
          indent = { tab-width = 4; unit = "    "; };
          language-server = {
            name = "pylsp";
            auto-format = false;
            command = "${pkgs.python311Packages.python-lsp-server}/bin/pylsp";
            config.pylsp.plugins = {
              flake8 = {
                enabled = true;
                ignore = [ "E501" ];
                lineLength = 80;
              };
              autopep8 = { enabled = false; };
              mccabe = { enabled = false; };
              pycodestyle = { enabled = false; };
              pyflakes = { enabled = false; };
              pylint = { enabled = false; };
              yapf = { enabled = false; };
              ruff = { enabled = false; };
            };
          };
        }
        {
          name = "html";
          language-server = {
            name = "emmet-ls";
            command = "${pkgs.emmet-ls}/bin/emmet-ls";
            args = [ "--stdio" ];
          };
        }
        # ... add nore languages here:
      ];
    };
  };
}
