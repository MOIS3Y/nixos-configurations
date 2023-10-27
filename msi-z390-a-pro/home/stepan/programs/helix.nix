# █░█ █▀▀ █░░ █ ▀▄▀ ▀
# █▀█ ██▄ █▄▄ █ █░█ ▄
# -- -- -- -- -- -- -

{ config, pkgs, ... }: {
  programs.helix = {
    enable = true;
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
              "selections"
              "position"
              "file-encoding"
              "file-line-ending"
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
          auto-format = false;
          language-server = {
            name = "nil";
            command = "${pkgs.nil}/bin/nil";
            nix.config = {};  # <-- important I don’t know why(
          };
        }
        # ... add nore LSP here:
      ];
    };
  };
}
