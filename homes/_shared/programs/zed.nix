# ▀█ █▀▀ █▀▄ ▀
# █▄ ██▄ █▄▀ ▄
# -- -- -- --

{ pkgs, ... }: {
  programs.zed-editor = {
    enable = true;
    extensions = [
      "basher"
      "blueprint"
      "caddyfile"
      "catppuccin"
      "catppuccin-icons"
      "color-highlight"
      "csv"
      "django"
      "django-snippets"
      "dockerfile"
      "docker-compose"
      "emmet"
      "git-firefly"
      "jinja2"
      "lua"
      "meson"
      "nginx"
      "nix"
      "python-requirements"
      "python-snippets"
      "scss"
      "toml"
      "tombi"
      "vala"
      "xml"
    ];
    extraPackages = with pkgs; [
      basedpyright
      bash-language-server
      blueprint-compiler
      caddy
      docker-compose-language-service
      dockerfile-language-server
      emmet-language-server
      (lua5_1.withPackages (ps: with ps; [ luarocks ]))
      nginx-language-server
      nil
      nixd
      nixfmt
      (python3.withPackages (
        ps: with ps; [
          python-lsp-server
          python-lsp-ruff
        ]
      ))
      mesonlsp
      rustfmt
      shellcheck
      shfmt
      tombi
      vala-language-server
      vscode-langservers-extracted
    ];
    userSettings = {

      # -- -- -- General -- -- -- #

      # General Settings
      use_system_prompts = false;
      use_system_path_prompts = false;

      # Privacy
      telemetry = {
        diagnostics = false;
        metrics = false;
      };

      # Autoupdate
      auto_update = false;


      # -- -- -- Appearance -- -- -- #

      # Theme
      theme = {
        mode = "dark";
        light = "Catppuccin Latte";
        dark = "Catppuccin Mocha";
      };

      # Icon Theme
      icon_theme = {
        mode = "dark";
        light = "Catppuccin Mocha";
        dark = "Catppuccin Mocha";
      };

      # Buffer Font
      buffer_font_family = "JetBrainsMono Nerd Font Mono";
      buffer_font_fallbacks = [ ".ZedMono" ];
      buffer_font_size = 14.5;
      buffer_line_height = "standard";

      # UI Font
      ui_font_family = "Ubuntu";
      ui_font_fallbacks = [ ".ZedSans" ];
      ui_font_size = 15;

      # Cursor
      multi_cursor_modifier = "alt";
      cursor_blink = true;
      cursor_shape = "bar";

      # Highlighting
      current_line_highlight = "all";


      # -- -- -- Keymap -- -- -- #

      # Base Keymap
      base_keymap = "VSCode";

      # Modal Editing
      vim_mode = true;


      # -- -- -- Editor -- -- -- #

      # Auto Save
      autosave = "off";

      # Scrolling
      autoscroll_on_clicks = true;

      # Signature help
      auto_signature_help = true;
      snippet_sort_order = "bottom";

      # Gutter
      relative_line_numbers = "disabled";

      # Minimap
      minimap = {
        thumb_border = "full";
        show = "auto";
      };

      # Wrapping
      soft_wrap = "editor_width";
      show_wrap_guides = true;
      wrap_guides = [
        80
      ];

      # Indent Guides
      indent_guides = {
        active_line_width = 1;
        background_coloring = "disabled";
        enabled = true;
        coloring = "indent_aware";
      };

      # Formating
      format_on_save = "off";
      remove_trailing_whitespace_on_save = true;
      ensure_final_newline_on_save = true;

      # Completions
      completions = {
        lsp = true;
        words_min_length = 3;
        words = "fallback";
        lsp_fetch_timeout_ms = 0;
      };

      # Inlay Hints
      lsp_document_colors = "inlay";

      # Miscellaneous
      extend_comment_on_newline = true;
      colorize_brackets = true;


      # -- -- -- Languages & tools -- -- -- #

      # LSP
      enable_language_server = true;

      # Languages
      languages = {
        HTML = {
          enable_language_server = true;
          language_servers = [
            "emmet-language-server"
            "!html"
          ];
        };
        Nix = {
          tab_size = 2;
          language_servers = [
            "nixd"
            "!nil"
          ];
          formatter = {
            external = {
              command = "nixfmt";
              arguments = [ "--quiet" "--" ];
            };
          };
        };
      };


      # -- -- -- Window & Layout -- -- -- #

      # Title Bar
      title_bar = {
        show_sign_in = true;
        show_user_picture = true;
        show_project_items = true;
        show_branch_icon = true;
      };

      # Tab Bar
      tab_bar = {
        show_nav_history_buttons = true;
        show = true;
      };
      tabs = {
        file_icons = true;
        git_status = true;
        show_diagnostics = "off";
      };


      # -- -- -- Panels -- -- -- #

      # Project Panel
      project_panel = {
        entry_spacing = "standard";
        dock = "left";
        button = true;
      };
      status_bar = {
        cursor_position_button = true;
        active_language_button = true;
      };

      # Git Panel
      git_panel = {
        dock = "left";
        button = true;
      };


      # -- -- -- Version Control -- -- -- #
      git = {
        inline_blame = {
          show_commit_summary = false;
          padding = 7;
          delay_ms = 500;
          enabled = true;
        };
      };


      # -- -- -- Terminal -- -- -- #
      terminal = {
        font_size = 15.0;
        font_family = "JetBrainsMono Nerd Font Mono";
        dock = "bottom";
        blinking = "on";
        cursor_shape = "underline";
      };


      # -- -- -- AI -- -- -- #
      disable_ai = false;  # You were supposed to fight evil, not join it. :)
    };
    # TODO: Add keymaps
    # userKeymaps = {};
  };
}
