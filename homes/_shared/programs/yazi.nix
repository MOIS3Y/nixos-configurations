# █▄█ ▄▀█ ▀█ █ ▀
# ░█░ █▀█ █▄ █ ▄
# -- -- -- -- --
# Configuration for Yazi terminal file manager.

{
  config,
  pkgs,
  ...
}:
let
  inherit (config.matugen) mode;
  palette = config.matugen.theme.custom.palette.${mode};
in
{
  programs.yazi = {
    enable = true;
    enableBashIntegration = true;
    enableZshIntegration = true;
    shellWrapperName = "y";

    extraPackages = with pkgs; [
      wl-clipboard
      dragon-drop
    ];

    initLua = ''
       require("full-border"):setup()

       function Linemode:size_and_mtime()
      	  local time = math.floor(self._file.cha.mtime or 0)
        	if time == 0 then
           time = ""
         elseif os.date("%Y", time) == os.date("%Y") then
           time = os.date("%b %d %H:%M", time)
         else
       		time = os.date("%b %d  %Y", time)
        	end

        	local size = self._file:size()
        	return string.format(
           "%s %s", size and ya.readable_size(size) or "-", time
         )
       end
    '';

    plugins = {
      full-border = pkgs.yaziPlugins.full-border;
    };

    settings = {
      mgr = {
        sort_by = "mtime";
        sort_sensitive = false;
        sort_reverse = true;
        sort_dir_first = true;
        linemode = "size_and_mtime";
      };
      opener = {
        edit = [
          {
            run = "\${EDITOR:-vi} %s";
            block = true;
            desc = "$EDITOR";
          }
        ];
        play = [
          {
            run = "celluloid %s";
            orphan = true;
            desc = "Celluloid";
          }
        ];
        image = [
          {
            run = "imv %s";
            orphan = true;
            desc = "IMV";
          }
        ];
        open = [
          {
            run = "xdg-open %s";
            desc = "Open";
          }
        ];
      };
      open = {
        prepend_rules = [
          {
            mime = "text/*";
            use = "edit";
          }
          {
            mime = "video/*";
            use = "play";
          }
          {
            mime = "audio/*";
            use = "play";
          }
          {
            mime = "image/*";
            use = "image";
          }
          {
            url = "*";
            use = "open";
          }
        ];
      };
    };

    keymap = {
      mgr = {
        prepend_keymap = [
          {
            on = [ "<C-n>" ];
            run = "shell -- dragon-drop -x -i -T %s";
            desc = "Drag and drop (dragon)";
          }
        ];
      };
    };

    # yanked from: https://github.com/catppuccin/yazi
    theme = {
      app.overall = {
        bg = palette.bg_base;
      };

      mgr = {
        cwd = {
          fg = palette.cyan;
        };
        find_keyword = {
          fg = palette.yellow;
          italic = true;
        };
        find_position = {
          fg = palette.magenta;
          bg = "reset";
          italic = true;
        };
        marker_copied = {
          fg = palette.green;
          bg = palette.green;
        };
        marker_cut = {
          fg = palette.red;
          bg = palette.red;
        };
        marker_marked = {
          fg = palette.cyan;
          bg = palette.cyan;
        };
        marker_selected = {
          fg = palette.blue;
          bg = palette.blue;
        };
        count_copied = {
          fg = palette.bg_base;
          bg = palette.green;
        };
        count_cut = {
          fg = palette.bg_base;
          bg = palette.red;
        };
        count_selected = {
          fg = palette.bg_base;
          bg = palette.blue;
        };
        border_symbol = "│";
        border_style = {
          fg = palette.border;
        };
      };

      tabs = {
        active = {
          fg = palette.bg_base;
          bg = palette.fg_text;
          bold = true;
        };
        inactive = {
          fg = palette.fg_text;
          bg = palette.bg_surface;
        };
      };

      mode = {
        normal_main = {
          fg = palette.bg_base;
          bg = palette.blue;
          bold = true;
        };
        normal_alt = {
          fg = palette.blue;
          bg = palette.bg_surface_alt;
        };
        select_main = {
          fg = palette.bg_base;
          bg = palette.green;
          bold = true;
        };
        select_alt = {
          fg = palette.green;
          bg = palette.bg_surface_alt;
        };
        unset_main = {
          fg = palette.bg_base;
          bg = palette.bright_red;
          bold = true;
        };
        unset_alt = {
          fg = palette.bright_red;
          bg = palette.bg_surface_alt;
        };
      };

      indicator = {
        parent = {
          fg = palette.bg_base;
          bg = palette.fg_text;
        };
        current = {
          fg = palette.bg_base;
          bg = palette.blue;
        };
        preview = {
          fg = palette.bg_base;
          bg = palette.fg_text;
        };
      };

      status = {
        sep_left = {
          open = "";
          close = "";
        };
        sep_right = {
          open = "";
          close = "";
        };
        progress_label = {
          fg = "#ffffff";
          bold = true;
        };
        progress_normal = {
          fg = palette.green;
          bg = palette.bg_surface;
        };
        progress_error = {
          fg = palette.yellow;
          bg = palette.red;
        };
        perm_type = {
          fg = palette.blue;
        };
        perm_read = {
          fg = palette.yellow;
        };
        perm_write = {
          fg = palette.red;
        };
        perm_exec = {
          fg = palette.green;
        };
        perm_sep = {
          fg = palette.border;
        };
      };

      input = {
        border = {
          fg = palette.blue;
        };
        title = { };
        value = { };
        selected = {
          reversed = true;
        };
      };

      pick = {
        border = {
          fg = palette.blue;
        };
        active = {
          fg = palette.magenta;
        };
        inactive = { };
      };

      confirm = {
        border = {
          fg = palette.blue;
        };
        title = {
          fg = palette.blue;
        };
        body = { };
        list = { };
        btn_yes = {
          reversed = true;
        };
        btn_no = { };
      };

      cmp = {
        border = {
          fg = palette.blue;
        };
      };

      tasks = {
        border = {
          fg = palette.blue;
        };
        title = { };
        hovered = {
          fg = palette.magenta;
          bold = true;
        };
      };

      which = {
        mask = {
          bg = palette.bg_surface_alt;
        };
        cand = {
          fg = palette.cyan;
        };
        rest = {
          fg = palette.fg_subtext;
        };
        desc = {
          fg = palette.magenta;
        };
        separator = "  ";
        separator_style = {
          fg = palette.border_alt;
        };
      };

      help = {
        on = {
          fg = palette.cyan;
        };
        run = {
          fg = palette.magenta;
        };
        desc = {
          fg = palette.fg_subtext;
        };
        hovered = {
          bg = palette.border_alt;
          bold = true;
        };
        footer = {
          fg = palette.fg_text;
          bg = palette.bg_surface;
        };
      };

      notify = {
        title_info = {
          fg = palette.cyan;
        };
        title_warn = {
          fg = palette.yellow;
        };
        title_error = {
          fg = palette.red;
        };
      };

      filetype = {
        rules = [
          # Media
          {
            mime = "image/*";
            fg = palette.cyan;
          }
          {
            mime = "{audio,video}/*";
            fg = palette.yellow;
          }
          # Archives
          {
            mime = "application/*zip";
            fg = palette.magenta;
          }
          {
            mime = "application/x-{tar,bzip*,7z-compressed,xz,rar}";
            fg = palette.magenta;
          }
          # Documents
          {
            mime = "application/{pdf,doc,rtf}";
            fg = palette.green;
          }
          # Virtual file system
          {
            mime = "vfs/{absent,stale}";
            fg = palette.bg_surface;
          }
          # Special file
          {
            url = "*";
            is = "orphan";
            bg = palette.red;
          }
          {
            url = "*";
            is = "exec";
            fg = palette.green;
          }
          # Dummy file
          {
            url = "*";
            is = "dummy";
            bg = palette.red;
          }
          {
            url = "*/";
            is = "dummy";
            bg = palette.red;
          }
          # Fallback
          {
            url = "*/";
            fg = palette.blue;
          }
        ];
      };

      spot = {
        border = {
          fg = palette.blue;
        };
        title = {
          fg = palette.blue;
        };
        tbl_cell = {
          fg = palette.blue;
          reversed = true;
        };
        tbl_col = {
          bold = true;
        };
      };

      icon = {
        prepend_dirs = [
          {
            name = "Downloads";
            text = "󰇚";
            fg = palette.blue;
          }
          {
            name = "Documents";
            text = "󰈙";
            fg = palette.blue;
          }
          {
            name = "Pictures";
            text = "󰋩";
            fg = palette.blue;
          }
          {
            name = "Videos";
            text = "󰈫";
            fg = palette.blue;
          }
          {
            name = "Music";
            text = "󰝚";
            fg = palette.blue;
          }
          {
            name = "Desktop";
            text = "󰇄";
            fg = palette.blue;
          }
          {
            name = "Public";
            text = "󰢹";
            fg = palette.blue;
          }
          {
            name = "Templates";
            text = "󰇚";
            fg = palette.blue;
          }
        ];
        prepend_conds = [
          {
            "if" = "dir";
            text = "󰉋";
            fg = palette.blue;
          }
        ];
        files = [
          {
            name = "kritadisplayrc";
            text = "";
            fg = palette.magenta;
          }
          {
            name = ".gtkrc-2.0";
            text = "";
            fg = palette.fg_subtext;
          }
          {
            name = "bspwmrc";
            text = "";
            fg = palette.bg_surface_alt;
          }
          {
            name = "webpack";
            text = "󰜫";
            fg = palette.bright_blue;
          }
          {
            name = "tsconfig.json";
            text = "";
            fg = palette.bright_blue;
          }
          {
            name = ".vimrc";
            text = "";
            fg = palette.green;
          }
          {
            name = "gemfile$";
            text = "";
            fg = palette.bg_surface_alt;
          }
          {
            name = "xmobarrc";
            text = "";
            fg = palette.red;
          }
          {
            name = "avif";
            text = "";
            fg = palette.border;
          }
          {
            name = "fp-info-cache";
            text = "";
            fg = palette.fg_subtext;
          }
          {
            name = ".zshrc";
            text = "";
            fg = palette.green;
          }
          {
            name = "robots.txt";
            text = "󰚩";
            fg = palette.fg_subtext;
          }
          {
            name = "dockerfile";
            text = "󰡨";
            fg = palette.blue;
          }
          {
            name = ".git-blame-ignore-revs";
            text = "";
            fg = palette.yellow;
          }
          {
            name = ".nvmrc";
            text = "";
            fg = palette.green;
          }
          {
            name = "hyprpaper.conf";
            text = "";
            fg = palette.bright_blue;
          }
          {
            name = ".prettierignore";
            text = "";
            fg = palette.blue;
          }
          {
            name = "rakefile";
            text = "";
            fg = palette.bg_surface_alt;
          }
          {
            name = "code_of_conduct";
            text = "";
            fg = palette.red;
          }
          {
            name = "cmakelists.txt";
            text = "";
            fg = palette.fg_text;
          }
          {
            name = ".env";
            text = "";
            fg = palette.yellow;
          }
          {
            name = "copying.lesser";
            text = "";
            fg = palette.yellow;
          }
          {
            name = "readme";
            text = "󰂺";
            fg = palette.fg_subtext;
          }
          {
            name = "settings.gradle";
            text = "";
            fg = palette.border_alt;
          }
          {
            name = "gruntfile.coffee";
            text = "";
            fg = palette.yellow;
          }
          {
            name = ".eslintignore";
            text = "";
            fg = palette.border_alt;
          }
          {
            name = "kalgebrarc";
            text = "";
            fg = palette.blue;
          }
          {
            name = "kdenliverc";
            text = "";
            fg = palette.blue;
          }
          {
            name = ".prettierrc.cjs";
            text = "";
            fg = palette.blue;
          }
          {
            name = "cantorrc";
            text = "";
            fg = palette.blue;
          }
          {
            name = "rmd";
            text = "";
            fg = palette.bright_blue;
          }
          {
            name = "vagrantfile$";
            text = "";
            fg = palette.fg_subtext;
          }
          {
            name = ".Xauthority";
            text = "";
            fg = palette.yellow;
          }
          {
            name = "prettier.config.ts";
            text = "";
            fg = palette.blue;
          }
          {
            name = "node_modules";
            text = "";
            fg = palette.red;
          }
          {
            name = ".prettierrc.toml";
            text = "";
            fg = palette.blue;
          }
          {
            name = "build.zig.zon";
            text = "";
            fg = palette.yellow;
          }
          {
            name = ".ds_store";
            text = "";
            fg = palette.bg_surface;
          }
          {
            name = "PKGBUILD";
            text = "";
            fg = palette.blue;
          }
          {
            name = ".prettierrc";
            text = "";
            fg = palette.blue;
          }
          {
            name = ".bash_profile";
            text = "";
            fg = palette.green;
          }
          {
            name = ".npmignore";
            text = "";
            fg = palette.red;
          }
          {
            name = ".mailmap";
            text = "󰊢";
            fg = palette.yellow;
          }
          {
            name = ".codespellrc";
            text = "󰓆";
            fg = palette.green;
          }
          {
            name = "svelte.config.js";
            text = "";
            fg = palette.yellow;
          }
          {
            name = "eslint.config.ts";
            text = "";
            fg = palette.border_alt;
          }
          {
            name = "config";
            text = "";
            fg = palette.border;
          }
          {
            name = ".gitlab-ci.yml";
            text = "";
            fg = palette.yellow;
          }
          {
            name = ".gitconfig";
            text = "";
            fg = palette.yellow;
          }
          {
            name = "_gvimrc";
            text = "";
            fg = palette.green;
          }
          {
            name = ".xinitrc";
            text = "";
            fg = palette.yellow;
          }
          {
            name = "checkhealth";
            text = "󰓙";
            fg = palette.blue;
          }
          {
            name = "sxhkdrc";
            text = "";
            fg = palette.bg_surface_alt;
          }
          {
            name = ".bashrc";
            text = "";
            fg = palette.green;
          }
          {
            name = "tailwind.config.mjs";
            text = "󱏿";
            fg = palette.bright_blue;
          }
          {
            name = "ext_typoscript_setup.txt";
            text = "";
            fg = palette.yellow;
          }
          {
            name = "commitlint.config.ts";
            text = "󰜘";
            fg = palette.cyan;
          }
          {
            name = "py.typed";
            text = "";
            fg = palette.yellow;
          }
          {
            name = ".nanorc";
            text = "";
            fg = palette.bg_surface_alt;
          }
          {
            name = "commit_editmsg";
            text = "";
            fg = palette.yellow;
          }
          {
            name = ".luaurc";
            text = "";
            fg = palette.blue;
          }
          {
            name = ".editorconfig";
            text = "";
            fg = palette.fg_subtext;
          }
          {
            name = "justfile";
            text = "";
            fg = palette.border;
          }
          {
            name = "kdeglobals";
            text = "";
            fg = palette.blue;
          }
          {
            name = "license.md";
            text = "";
            fg = palette.yellow;
          }
          {
            name = ".clang-format";
            text = "";
            fg = palette.border;
          }
          {
            name = "docker-compose.yaml";
            text = "󰡨";
            fg = palette.blue;
          }
          {
            name = "copying";
            text = "";
            fg = palette.yellow;
          }
          {
            name = "go.mod";
            text = "";
            fg = palette.bright_blue;
          }
          {
            name = "lxqt.conf";
            text = "";
            fg = palette.blue;
          }
          {
            name = "brewfile";
            text = "";
            fg = palette.bg_surface_alt;
          }
          {
            name = "gulpfile.coffee";
            text = "";
            fg = palette.red;
          }
          {
            name = ".dockerignore";
            text = "󰡨";
            fg = palette.blue;
          }
          {
            name = ".settings.json";
            text = "";
            fg = palette.fg_subtext;
          }
          {
            name = "tailwind.config.js";
            text = "󱏿";
            fg = palette.bright_blue;
          }
          {
            name = ".clang-tidy";
            text = "";
            fg = palette.border;
          }
          {
            name = ".gvimrc";
            text = "";
            fg = palette.green;
          }
          {
            name = "nuxt.config.cjs";
            text = "󱄆";
            fg = palette.green;
          }
          {
            name = "xsettingsd.conf";
            text = "";
            fg = palette.yellow;
          }
          {
            name = "nuxt.config.js";
            text = "󱄆";
            fg = palette.green;
          }
          {
            name = "eslint.config.cjs";
            text = "";
            fg = palette.border_alt;
          }
          {
            name = "sym-lib-table";
            text = "";
            fg = palette.fg_subtext;
          }
          {
            name = ".condarc";
            text = "";
            fg = palette.green;
          }
          {
            name = "xmonad.hs";
            text = "";
            fg = palette.red;
          }
          {
            name = "tmux.conf";
            text = "";
            fg = palette.green;
          }
          {
            name = "xmobarrc.hs";
            text = "";
            fg = palette.red;
          }
          {
            name = ".prettierrc.yaml";
            text = "";
            fg = palette.blue;
          }
          {
            name = ".pre-commit-config.yaml";
            text = "󰛢";
            fg = palette.yellow;
          }
          {
            name = "i3blocks.conf";
            text = "";
            fg = palette.fg_subtext;
          }
          {
            name = "xorg.conf";
            text = "";
            fg = palette.yellow;
          }
          {
            name = ".zshenv";
            text = "";
            fg = palette.green;
          }
          {
            name = "vlcrc";
            text = "󰕼";
            fg = palette.yellow;
          }
          {
            name = "license";
            text = "";
            fg = palette.yellow;
          }
          {
            name = "unlicense";
            text = "";
            fg = palette.yellow;
          }
          {
            name = "tmux.conf.local";
            text = "";
            fg = palette.green;
          }
          {
            name = ".SRCINFO";
            text = "󰣇";
            fg = palette.blue;
          }
          {
            name = "tailwind.config.ts";
            text = "󱏿";
            fg = palette.bright_blue;
          }
          {
            name = "security.md";
            text = "󰒃";
            fg = palette.white;
          }
          {
            name = "security";
            text = "󰒃";
            fg = palette.white;
          }
          {
            name = ".eslintrc";
            text = "";
            fg = palette.border_alt;
          }
          {
            name = "gradle.properties";
            text = "";
            fg = palette.border_alt;
          }
          {
            name = "code_of_conduct.md";
            text = "";
            fg = palette.red;
          }
          {
            name = "PrusaSlicerGcodeViewer.ini";
            text = "";
            fg = palette.yellow;
          }
          {
            name = "PrusaSlicer.ini";
            text = "";
            fg = palette.yellow;
          }
          {
            name = "procfile";
            text = "";
            fg = palette.border;
          }
          {
            name = "mpv.conf";
            text = "";
            fg = palette.bg_base;
          }
          {
            name = ".prettierrc.json5";
            text = "";
            fg = palette.blue;
          }
          {
            name = "i3status.conf";
            text = "";
            fg = palette.fg_subtext;
          }
          {
            name = "prettier.config.mjs";
            text = "";
            fg = palette.blue;
          }
          {
            name = ".pylintrc";
            text = "";
            fg = palette.border;
          }
          {
            name = "prettier.config.cjs";
            text = "";
            fg = palette.blue;
          }
          {
            name = ".luacheckrc";
            text = "";
            fg = palette.blue;
          }
          {
            name = "containerfile";
            text = "󰡨";
            fg = palette.blue;
          }
          {
            name = "eslint.config.mjs";
            text = "";
            fg = palette.border_alt;
          }
          {
            name = "gruntfile.js";
            text = "";
            fg = palette.yellow;
          }
          {
            name = "bun.lockb";
            text = "";
            fg = palette.fg_subtext;
          }
          {
            name = ".gitattributes";
            text = "";
            fg = palette.yellow;
          }
          {
            name = "gruntfile.ts";
            text = "";
            fg = palette.yellow;
          }
          {
            name = "pom.xml";
            text = "";
            fg = palette.bg_surface_alt;
          }
          {
            name = "favicon.ico";
            text = "";
            fg = palette.yellow;
          }
          {
            name = "package-lock.json";
            text = "";
            fg = palette.bg_surface_alt;
          }
          {
            name = "build";
            text = "";
            fg = palette.green;
          }
          {
            name = "package.json";
            text = "";
            fg = palette.red;
          }
          {
            name = "nuxt.config.ts";
            text = "󱄆";
            fg = palette.green;
          }
          {
            name = "nuxt.config.mjs";
            text = "󱄆";
            fg = palette.green;
          }
          {
            name = "mix.lock";
            text = "";
            fg = palette.border;
          }
          {
            name = "makefile";
            text = "";
            fg = palette.border;
          }
          {
            name = "gulpfile.js";
            text = "";
            fg = palette.red;
          }
          {
            name = "lxde-rc.xml";
            text = "";
            fg = palette.fg_subtext;
          }
          {
            name = "kritarc";
            text = "";
            fg = palette.magenta;
          }
          {
            name = "gtkrc";
            text = "";
            fg = palette.fg_subtext;
          }
          {
            name = "ionic.config.json";
            text = "";
            fg = palette.blue;
          }
          {
            name = ".prettierrc.mjs";
            text = "";
            fg = palette.blue;
          }
          {
            name = ".prettierrc.yml";
            text = "";
            fg = palette.blue;
          }
          {
            name = ".npmrc";
            text = "";
            fg = palette.red;
          }
          {
            name = "weston.ini";
            text = "";
            fg = palette.yellow;
          }
          {
            name = "gulpfile.babel.js";
            text = "";
            fg = palette.red;
          }
          {
            name = "i18n.config.ts";
            text = "󰗊";
            fg = palette.border;
          }
          {
            name = "commitlint.config.js";
            text = "󰜘";
            fg = palette.cyan;
          }
          {
            name = ".gitmodules";
            text = "";
            fg = palette.yellow;
          }
          {
            name = "gradle-wrapper.properties";
            text = "";
            fg = palette.border_alt;
          }
          {
            name = "hypridle.conf";
            text = "";
            fg = palette.bright_blue;
          }
          {
            name = "vercel.json";
            text = "▲";
            fg = palette.fg_subtext;
          }
          {
            name = "hyprlock.conf";
            text = "";
            fg = palette.bright_blue;
          }
          {
            name = "go.sum";
            text = "";
            fg = palette.bright_blue;
          }
          {
            name = "kdenlive-layoutsrc";
            text = "";
            fg = palette.blue;
          }
          {
            name = "gruntfile.babel.js";
            text = "";
            fg = palette.yellow;
          }
          {
            name = "compose.yml";
            text = "󰡨";
            fg = palette.blue;
          }
          {
            name = "i18n.config.js";
            text = "󰗊";
            fg = palette.border;
          }
          {
            name = "readme.md";
            text = "󰂺";
            fg = palette.fg_subtext;
          }
          {
            name = "gradlew";
            text = "";
            fg = palette.border_alt;
          }
          {
            name = "go.work";
            text = "";
            fg = palette.bright_blue;
          }
          {
            name = "gulpfile.ts";
            text = "";
            fg = palette.red;
          }
          {
            name = "gnumakefile";
            text = "";
            fg = palette.border;
          }
          {
            name = "FreeCAD.conf";
            text = "";
            fg = palette.red;
          }
          {
            name = "compose.yaml";
            text = "󰡨";
            fg = palette.blue;
          }
          {
            name = "eslint.config.js";
            text = "";
            fg = palette.border_alt;
          }
          {
            name = "hyprland.conf";
            text = "";
            fg = palette.bright_blue;
          }
          {
            name = "docker-compose.yml";
            text = "󰡨";
            fg = palette.blue;
          }
          {
            name = "groovy";
            text = "";
            fg = palette.border_alt;
          }
          {
            name = "QtProject.conf";
            text = "";
            fg = palette.green;
          }
          {
            name = "platformio.ini";
            text = "";
            fg = palette.yellow;
          }
          {
            name = "build.gradle";
            text = "";
            fg = palette.border_alt;
          }
          {
            name = ".nuxtrc";
            text = "󱄆";
            fg = palette.green;
          }
          {
            name = "_vimrc";
            text = "";
            fg = palette.green;
          }
          {
            name = ".zprofile";
            text = "";
            fg = palette.green;
          }
          {
            name = ".xsession";
            text = "";
            fg = palette.yellow;
          }
          {
            name = "prettier.config.js";
            text = "";
            fg = palette.blue;
          }
          {
            name = ".babelrc";
            text = "";
            fg = palette.yellow;
          }
          {
            name = "workspace";
            text = "";
            fg = palette.green;
          }
          {
            name = ".prettierrc.json";
            text = "";
            fg = palette.blue;
          }
          {
            name = ".prettierrc.js";
            text = "";
            fg = palette.blue;
          }
          {
            name = ".Xresources";
            text = "";
            fg = palette.yellow;
          }
          {
            name = ".gitignore";
            text = "";
            fg = palette.yellow;
          }
          {
            name = ".justfile";
            text = "";
            fg = palette.border;
          }
        ];

        exts = [
          {
            name = "otf";
            text = "";
            fg = palette.fg_subtext;
          }
          {
            name = "import";
            text = "";
            fg = palette.fg_subtext;
          }
          {
            name = "krz";
            text = "";
            fg = palette.magenta;
          }
          {
            name = "adb";
            text = "";
            fg = palette.cyan;
          }
          {
            name = "ttf";
            text = "";
            fg = palette.fg_subtext;
          }
          {
            name = "webpack";
            text = "󰜫";
            fg = palette.bright_blue;
          }
          {
            name = "dart";
            text = "";
            fg = palette.border_alt;
          }
          {
            name = "vsh";
            text = "";
            fg = palette.border;
          }
          {
            name = "doc";
            text = "󰈬";
            fg = palette.border_alt;
          }
          {
            name = "zsh";
            text = "";
            fg = palette.green;
          }
          {
            name = "ex";
            text = "";
            fg = palette.border;
          }
          {
            name = "hx";
            text = "";
            fg = palette.yellow;
          }
          {
            name = "fodt";
            text = "";
            fg = palette.bright_blue;
          }
          {
            name = "mojo";
            text = "";
            fg = palette.yellow;
          }
          {
            name = "templ";
            text = "";
            fg = palette.yellow;
          }
          {
            name = "nix";
            text = "";
            fg = palette.bright_blue;
          }
          {
            name = "cshtml";
            text = "󱦗";
            fg = palette.border_alt;
          }
          {
            name = "fish";
            text = "";
            fg = palette.border_alt;
          }
          {
            name = "ply";
            text = "󰆧";
            fg = palette.border;
          }
          {
            name = "sldprt";
            text = "󰻫";
            fg = palette.green;
          }
          {
            name = "gemspec";
            text = "";
            fg = palette.bg_surface_alt;
          }
          {
            name = "mjs";
            text = "";
            fg = palette.yellow;
          }
          {
            name = "csh";
            text = "";
            fg = palette.border_alt;
          }
          {
            name = "cmake";
            text = "";
            fg = palette.fg_text;
          }
          {
            name = "fodp";
            text = "";
            fg = palette.yellow;
          }
          {
            name = "vi";
            text = "";
            fg = palette.yellow;
          }
          {
            name = "msf";
            text = "";
            fg = palette.blue;
          }
          {
            name = "blp";
            text = "󰺾";
            fg = palette.blue;
          }
          {
            name = "less";
            text = "";
            fg = palette.bg_surface;
          }
          {
            name = "sh";
            text = "";
            fg = palette.border_alt;
          }
          {
            name = "odg";
            text = "";
            fg = palette.yellow;
          }
          {
            name = "mint";
            text = "󰌪";
            fg = palette.green;
          }
          {
            name = "dll";
            text = "";
            fg = palette.bg_base;
          }
          {
            name = "odf";
            text = "";
            fg = palette.red;
          }
          {
            name = "sqlite3";
            text = "";
            fg = palette.fg_subtext;
          }
          {
            name = "Dockerfile";
            text = "󰡨";
            fg = palette.blue;
          }
          {
            name = "ksh";
            text = "";
            fg = palette.border_alt;
          }
          {
            name = "rmd";
            text = "";
            fg = palette.bright_blue;
          }
          {
            name = "wv";
            text = "";
            fg = palette.bright_blue;
          }
          {
            name = "xml";
            text = "󰗀";
            fg = palette.yellow;
          }
          {
            name = "markdown";
            text = "";
            fg = palette.fg_text;
          }
          {
            name = "qml";
            text = "";
            fg = palette.green;
          }
          {
            name = "3gp";
            text = "";
            fg = palette.yellow;
          }
          {
            name = "pxi";
            text = "";
            fg = palette.blue;
          }
          {
            name = "flac";
            text = "";
            fg = palette.fg_subtext;
          }
          {
            name = "gpr";
            text = "";
            fg = palette.magenta;
          }
          {
            name = "huff";
            text = "󰡘";
            fg = palette.border_alt;
          }
          {
            name = "json";
            text = "";
            fg = palette.yellow;
          }
          {
            name = "gv";
            text = "󱁉";
            fg = palette.border_alt;
          }
          {
            name = "bmp";
            text = "";
            fg = palette.border;
          }
          {
            name = "lock";
            text = "";
            fg = palette.white;
          }
          {
            name = "sha384";
            text = "󰕥";
            fg = palette.border;
          }
          {
            name = "cobol";
            text = "⚙";
            fg = palette.border_alt;
          }
          {
            name = "cob";
            text = "⚙";
            fg = palette.border_alt;
          }
          {
            name = "java";
            text = "";
            fg = palette.red;
          }
          {
            name = "cjs";
            text = "";
            fg = palette.yellow;
          }
          {
            name = "qm";
            text = "";
            fg = palette.bright_blue;
          }
          {
            name = "ebuild";
            text = "";
            fg = palette.bg_surface;
          }
          {
            name = "mustache";
            text = "";
            fg = palette.yellow;
          }
          {
            name = "terminal";
            text = "";
            fg = palette.green;
          }
          {
            name = "ejs";
            text = "";
            fg = palette.yellow;
          }
          {
            name = "brep";
            text = "󰻫";
            fg = palette.green;
          }
          {
            name = "rar";
            text = "";
            fg = palette.yellow;
          }
          {
            name = "gradle";
            text = "";
            fg = palette.border_alt;
          }
          {
            name = "gnumakefile";
            text = "";
            fg = palette.border;
          }
          {
            name = "applescript";
            text = "";
            fg = palette.border;
          }
          {
            name = "elm";
            text = "";
            fg = palette.bright_blue;
          }
          {
            name = "ebook";
            text = "";
            fg = palette.yellow;
          }
          {
            name = "kra";
            text = "";
            fg = palette.magenta;
          }
          {
            name = "tf";
            text = "";
            fg = palette.border_alt;
          }
          {
            name = "xls";
            text = "󰈛";
            fg = palette.border_alt;
          }
          {
            name = "fnl";
            text = "";
            fg = palette.yellow;
          }
          {
            name = "kdbx";
            text = "";
            fg = palette.green;
          }
          {
            name = "kicad_pcb";
            text = "";
            fg = palette.fg_subtext;
          }
          {
            name = "cfg";
            text = "";
            fg = palette.border;
          }
          {
            name = "ape";
            text = "";
            fg = palette.bright_blue;
          }
          {
            name = "org";
            text = "";
            fg = palette.cyan;
          }
          {
            name = "yml";
            text = "";
            fg = palette.border;
          }
          {
            name = "swift";
            text = "";
            fg = palette.yellow;
          }
          {
            name = "eln";
            text = "";
            fg = palette.border;
          }
          {
            name = "sol";
            text = "";
            fg = palette.bright_blue;
          }
          {
            name = "awk";
            text = "";
            fg = palette.border_alt;
          }
          {
            name = "7z";
            text = "";
            fg = palette.yellow;
          }
          {
            name = "apl";
            text = "⍝";
            fg = palette.yellow;
          }
          {
            name = "epp";
            text = "";
            fg = palette.yellow;
          }
          {
            name = "app";
            text = "";
            fg = palette.bg_surface;
          }
          {
            name = "dot";
            text = "󱁉";
            fg = palette.border_alt;
          }
          {
            name = "kpp";
            text = "";
            fg = palette.magenta;
          }
          {
            name = "eot";
            text = "";
            fg = palette.fg_subtext;
          }
          {
            name = "hpp";
            text = "";
            fg = palette.border;
          }
          {
            name = "spec.tsx";
            text = "";
            fg = palette.border_alt;
          }
          {
            name = "hurl";
            text = "";
            fg = palette.red;
          }
          {
            name = "cxxm";
            text = "";
            fg = palette.bright_blue;
          }
          {
            name = "c";
            text = "";
            fg = palette.blue;
          }
          {
            name = "fcmacro";
            text = "";
            fg = palette.red;
          }
          {
            name = "sass";
            text = "";
            fg = palette.red;
          }
          {
            name = "yaml";
            text = "";
            fg = palette.border;
          }
          {
            name = "xz";
            text = "";
            fg = palette.yellow;
          }
          {
            name = "material";
            text = "󰔉";
            fg = palette.red;
          }
          {
            name = "json5";
            text = "";
            fg = palette.yellow;
          }
          {
            name = "signature";
            text = "λ";
            fg = palette.yellow;
          }
          {
            name = "3mf";
            text = "󰆧";
            fg = palette.border;
          }
          {
            name = "jpg";
            text = "";
            fg = palette.border;
          }
          {
            name = "xpi";
            text = "";
            fg = palette.yellow;
          }
          {
            name = "fcmat";
            text = "";
            fg = palette.red;
          }
          {
            name = "pot";
            text = "";
            fg = palette.bright_blue;
          }
          {
            name = "bin";
            text = "";
            fg = palette.bg_surface;
          }
          {
            name = "xlsx";
            text = "󰈛";
            fg = palette.border_alt;
          }
          {
            name = "aac";
            text = "";
            fg = palette.bright_blue;
          }
          {
            name = "kicad_sym";
            text = "";
            fg = palette.fg_subtext;
          }
          {
            name = "xcstrings";
            text = "";
            fg = palette.bright_blue;
          }
          {
            name = "lff";
            text = "";
            fg = palette.fg_subtext;
          }
          {
            name = "xcf";
            text = "";
            fg = palette.border_alt;
          }
          {
            name = "azcli";
            text = "";
            fg = palette.fg_subtext;
          }
          {
            name = "license";
            text = "";
            fg = palette.yellow;
          }
          {
            name = "jsonc";
            text = "";
            fg = palette.yellow;
          }
          {
            name = "xaml";
            text = "󰙳";
            fg = palette.border_alt;
          }
          {
            name = "md5";
            text = "󰕥";
            fg = palette.border;
          }
          {
            name = "xm";
            text = "";
            fg = palette.bright_blue;
          }
          {
            name = "sln";
            text = "";
            fg = palette.fg_subtext;
          }
          {
            name = "jl";
            text = "";
            fg = palette.border;
          }
          {
            name = "ml";
            text = "";
            fg = palette.yellow;
          }
          {
            name = "http";
            text = "";
            fg = palette.blue;
          }
          {
            name = "x";
            text = "";
            fg = palette.blue;
          }
          {
            name = "wvc";
            text = "";
            fg = palette.bright_blue;
          }
          {
            name = "wrz";
            text = "󰆧";
            fg = palette.border;
          }
          {
            name = "csproj";
            text = "󰪮";
            fg = palette.border_alt;
          }
          {
            name = "wrl";
            text = "󰆧";
            fg = palette.border;
          }
          {
            name = "wma";
            text = "";
            fg = palette.bright_blue;
          }
          {
            name = "woff2";
            text = "";
            fg = palette.fg_subtext;
          }
          {
            name = "woff";
            text = "";
            fg = palette.fg_subtext;
          }
          {
            name = "tscn";
            text = "";
            fg = palette.border;
          }
          {
            name = "webmanifest";
            text = "";
            fg = palette.yellow;
          }
          {
            name = "webm";
            text = "";
            fg = palette.yellow;
          }
          {
            name = "fcbak";
            text = "";
            fg = palette.red;
          }
          {
            name = "log";
            text = "󰌱";
            fg = palette.fg_text;
          }
          {
            name = "wav";
            text = "";
            fg = palette.bright_blue;
          }
          {
            name = "wasm";
            text = "";
            fg = palette.border_alt;
          }
          {
            name = "styl";
            text = "";
            fg = palette.green;
          }
          {
            name = "gif";
            text = "";
            fg = palette.border;
          }
          {
            name = "resi";
            text = "";
            fg = palette.red;
          }
          {
            name = "aiff";
            text = "";
            fg = palette.bright_blue;
          }
          {
            name = "sha256";
            text = "󰕥";
            fg = palette.border;
          }
          {
            name = "igs";
            text = "󰻫";
            fg = palette.green;
          }
          {
            name = "vsix";
            text = "";
            fg = palette.fg_subtext;
          }
          {
            name = "vim";
            text = "";
            fg = palette.green;
          }
          {
            name = "diff";
            text = "";
            fg = palette.bg_surface;
          }
          {
            name = "drl";
            text = "";
            fg = palette.bright_red;
          }
          {
            name = "erl";
            text = "";
            fg = palette.red;
          }
          {
            name = "vhdl";
            text = "󰍛";
            fg = palette.green;
          }
          {
            name = "🔥";
            text = "";
            fg = palette.yellow;
          }
          {
            name = "hrl";
            text = "";
            fg = palette.red;
          }
          {
            name = "fsi";
            text = "";
            fg = palette.bright_blue;
          }
          {
            name = "mm";
            text = "";
            fg = palette.bright_blue;
          }
          {
            name = "bz";
            text = "";
            fg = palette.yellow;
          }
          {
            name = "vh";
            text = "󰍛";
            fg = palette.green;
          }
          {
            name = "kdb";
            text = "";
            fg = palette.green;
          }
          {
            name = "gz";
            text = "";
            fg = palette.yellow;
          }
          {
            name = "cpp";
            text = "";
            fg = palette.bright_blue;
          }
          {
            name = "ui";
            text = "";
            fg = palette.fg_subtext;
          }
          {
            name = "txt";
            text = "󰈙";
            fg = palette.green;
          }
          {
            name = "spec.ts";
            text = "";
            fg = palette.bright_blue;
          }
          {
            name = "ccm";
            text = "";
            fg = palette.red;
          }
          {
            name = "typoscript";
            text = "";
            fg = palette.yellow;
          }
          {
            name = "typ";
            text = "";
            fg = palette.bright_cyan;
          }
          {
            name = "txz";
            text = "";
            fg = palette.yellow;
          }
          {
            name = "test.ts";
            text = "";
            fg = palette.bright_blue;
          }
          {
            name = "tsx";
            text = "";
            fg = palette.border_alt;
          }
          {
            name = "mk";
            text = "";
            fg = palette.border;
          }
          {
            name = "webp";
            text = "";
            fg = palette.border;
          }
          {
            name = "opus";
            text = "";
            fg = palette.fg_subtext;
          }
          {
            name = "bicep";
            text = "";
            fg = palette.bright_blue;
          }
          {
            name = "ts";
            text = "";
            fg = palette.bright_blue;
          }
          {
            name = "tres";
            text = "";
            fg = palette.border;
          }
          {
            name = "torrent";
            text = "";
            fg = palette.cyan;
          }
          {
            name = "cxx";
            text = "";
            fg = palette.bright_blue;
          }
          {
            name = "iso";
            text = "";
            fg = palette.bright_red;
          }
          {
            name = "ixx";
            text = "";
            fg = palette.bright_blue;
          }
          {
            name = "hxx";
            text = "";
            fg = palette.border;
          }
          {
            name = "gql";
            text = "";
            fg = palette.red;
          }
          {
            name = "tmux";
            text = "";
            fg = palette.green;
          }
          {
            name = "ini";
            text = "";
            fg = palette.border;
          }
          {
            name = "m3u8";
            text = "󰲹";
            fg = palette.red;
          }
          {
            name = "image";
            text = "";
            fg = palette.bright_red;
          }
          {
            name = "tfvars";
            text = "";
            fg = palette.border_alt;
          }
          {
            name = "tex";
            text = "";
            fg = palette.bg_surface;
          }
          {
            name = "cbl";
            text = "⚙";
            fg = palette.border_alt;
          }
          {
            name = "flc";
            text = "";
            fg = palette.fg_subtext;
          }
          {
            name = "elc";
            text = "";
            fg = palette.border;
          }
          {
            name = "test.tsx";
            text = "";
            fg = palette.border_alt;
          }
          {
            name = "twig";
            text = "";
            fg = palette.green;
          }
          {
            name = "sql";
            text = "";
            fg = palette.fg_subtext;
          }
          {
            name = "test.jsx";
            text = "";
            fg = palette.bright_blue;
          }
          {
            name = "htm";
            text = "";
            fg = palette.yellow;
          }
          {
            name = "gcode";
            text = "󰐫";
            fg = palette.fg_subtext;
          }
          {
            name = "test.js";
            text = "";
            fg = palette.yellow;
          }
          {
            name = "ino";
            text = "";
            fg = palette.bright_blue;
          }
          {
            name = "tcl";
            text = "󰛓";
            fg = palette.border_alt;
          }
          {
            name = "cljs";
            text = "";
            fg = palette.bright_blue;
          }
          {
            name = "tsconfig";
            text = "";
            fg = palette.yellow;
          }
          {
            name = "img";
            text = "";
            fg = palette.bright_red;
          }
          {
            name = "t";
            text = "";
            fg = palette.bright_blue;
          }
          {
            name = "fcstd1";
            text = "";
            fg = palette.red;
          }
          {
            name = "out";
            text = "";
            fg = palette.bg_surface;
          }
          {
            name = "jsx";
            text = "";
            fg = palette.bright_blue;
          }
          {
            name = "bash";
            text = "";
            fg = palette.green;
          }
          {
            name = "edn";
            text = "";
            fg = palette.bright_blue;
          }
          {
            name = "rss";
            text = "";
            fg = palette.yellow;
          }
          {
            name = "flf";
            text = "";
            fg = palette.fg_subtext;
          }
          {
            name = "cache";
            text = "";
            fg = palette.fg_subtext;
          }
          {
            name = "sbt";
            text = "";
            fg = palette.red;
          }
          {
            name = "cppm";
            text = "";
            fg = palette.bright_blue;
          }
          {
            name = "svelte";
            text = "";
            fg = palette.yellow;
          }
          {
            name = "mo";
            text = "∞";
            fg = palette.border;
          }
          {
            name = "sv";
            text = "󰍛";
            fg = palette.green;
          }
          {
            name = "ko";
            text = "";
            fg = palette.fg_subtext;
          }
          {
            name = "suo";
            text = "";
            fg = palette.fg_subtext;
          }
          {
            name = "sldasm";
            text = "󰻫";
            fg = palette.green;
          }
          {
            name = "icalendar";
            text = "";
            fg = palette.bg_surface_alt;
          }
          {
            name = "go";
            text = "";
            fg = palette.bright_blue;
          }
          {
            name = "sublime";
            text = "";
            fg = palette.yellow;
          }
          {
            name = "stl";
            text = "󰆧";
            fg = palette.border;
          }
          {
            name = "mobi";
            text = "";
            fg = palette.yellow;
          }
          {
            name = "graphql";
            text = "";
            fg = palette.red;
          }
          {
            name = "m3u";
            text = "󰲹";
            fg = palette.red;
          }
          {
            name = "cpy";
            text = "⚙";
            fg = palette.border_alt;
          }
          {
            name = "kdenlive";
            text = "";
            fg = palette.blue;
          }
          {
            name = "pyo";
            text = "";
            fg = palette.yellow;
          }
          {
            name = "po";
            text = "";
            fg = palette.yellow;
          }
          {
            name = "scala";
            text = "";
            fg = palette.red;
          }
          {
            name = "exs";
            text = "";
            fg = palette.border;
          }
          {
            name = "odp";
            text = "";
            fg = palette.yellow;
          }
          {
            name = "dump";
            text = "";
            fg = palette.fg_subtext;
          }
          {
            name = "stp";
            text = "󰻫";
            fg = palette.green;
          }
          {
            name = "step";
            text = "󰻫";
            fg = palette.green;
          }
          {
            name = "ste";
            text = "󰻫";
            fg = palette.green;
          }
          {
            name = "aif";
            text = "";
            fg = palette.bright_blue;
          }
          {
            name = "strings";
            text = "";
            fg = palette.bright_blue;
          }
          {
            name = "cp";
            text = "";
            fg = palette.bright_blue;
          }
          {
            name = "fsscript";
            text = "";
            fg = palette.bright_blue;
          }
          {
            name = "mli";
            text = "";
            fg = palette.yellow;
          }
          {
            name = "bak";
            text = "󰁯";
            fg = palette.border;
          }
          {
            name = "ssa";
            text = "󰨖";
            fg = palette.yellow;
          }
          {
            name = "toml";
            text = "";
            fg = palette.border_alt;
          }
          {
            name = "php";
            text = "";
            fg = palette.border;
          }
          {
            name = "zst";
            text = "";
            fg = palette.yellow;
          }
          {
            name = "spec.jsx";
            text = "";
            fg = palette.bright_blue;
          }
          {
            name = "kbx";
            text = "󰯄";
            fg = palette.fg_subtext;
          }
          {
            name = "fbx";
            text = "󰆧";
            fg = palette.border;
          }
          {
            name = "blend";
            text = "󰂫";
            fg = palette.yellow;
          }
          {
            name = "ifc";
            text = "󰻫";
            fg = palette.green;
          }
          {
            name = "spec.js";
            text = "";
            fg = palette.yellow;
          }
          {
            name = "so";
            text = "";
            fg = palette.fg_subtext;
          }
          {
            name = "desktop";
            text = "";
            fg = palette.bg_surface;
          }
          {
            name = "sml";
            text = "λ";
            fg = palette.yellow;
          }
          {
            name = "slvs";
            text = "󰻫";
            fg = palette.green;
          }
          {
            name = "pp";
            text = "";
            fg = palette.yellow;
          }
          {
            name = "ps1";
            text = "󰨊";
            fg = palette.fg_subtext;
          }
          {
            name = "dropbox";
            text = "";
            fg = palette.fg_subtext;
          }
          {
            name = "kicad_mod";
            text = "";
            fg = palette.fg_subtext;
          }
          {
            name = "bat";
            text = "";
            fg = palette.green;
          }
          {
            name = "slim";
            text = "";
            fg = palette.yellow;
          }
          {
            name = "skp";
            text = "󰻫";
            fg = palette.green;
          }
          {
            name = "css";
            text = "";
            fg = palette.blue;
          }
          {
            name = "xul";
            text = "";
            fg = palette.yellow;
          }
          {
            name = "ige";
            text = "󰻫";
            fg = palette.green;
          }
          {
            name = "glb";
            text = "";
            fg = palette.yellow;
          }
          {
            name = "ppt";
            text = "󰈧";
            fg = palette.red;
          }
          {
            name = "sha512";
            text = "󰕥";
            fg = palette.border;
          }
          {
            name = "ics";
            text = "";
            fg = palette.bg_surface_alt;
          }
          {
            name = "mdx";
            text = "";
            fg = palette.bright_blue;
          }
          {
            name = "sha1";
            text = "󰕥";
            fg = palette.border;
          }
          {
            name = "f3d";
            text = "󰻫";
            fg = palette.green;
          }
          {
            name = "ass";
            text = "󰨖";
            fg = palette.yellow;
          }
          {
            name = "godot";
            text = "";
            fg = palette.border;
          }
          {
            name = "ifb";
            text = "";
            fg = palette.bg_surface_alt;
          }
          {
            name = "cson";
            text = "";
            fg = palette.yellow;
          }
          {
            name = "lib";
            text = "";
            fg = palette.bg_base;
          }
          {
            name = "luac";
            text = "";
            fg = palette.bright_blue;
          }
          {
            name = "heex";
            text = "";
            fg = palette.border;
          }
          {
            name = "scm";
            text = "󰘧";
            fg = palette.fg_subtext;
          }
          {
            name = "psd1";
            text = "󰨊";
            fg = palette.border;
          }
          {
            name = "sc";
            text = "";
            fg = palette.red;
          }
          {
            name = "scad";
            text = "";
            fg = palette.yellow;
          }
          {
            name = "kts";
            text = "";
            fg = palette.fg_subtext;
          }
          {
            name = "svh";
            text = "󰍛";
            fg = palette.green;
          }
          {
            name = "mts";
            text = "";
            fg = palette.bright_blue;
          }
          {
            name = "nfo";
            text = "";
            fg = palette.yellow;
          }
          {
            name = "pck";
            text = "";
            fg = palette.border;
          }
          {
            name = "rproj";
            text = "󰗆";
            fg = palette.green;
          }
          {
            name = "rlib";
            text = "";
            fg = palette.yellow;
          }
          {
            name = "cljd";
            text = "";
            fg = palette.bright_blue;
          }
          {
            name = "ods";
            text = "";
            fg = palette.green;
          }
          {
            name = "res";
            text = "";
            fg = palette.red;
          }
          {
            name = "apk";
            text = "";
            fg = palette.green;
          }
          {
            name = "haml";
            text = "";
            fg = palette.fg_subtext;
          }
          {
            name = "d.ts";
            text = "";
            fg = palette.yellow;
          }
          {
            name = "razor";
            text = "󱦘";
            fg = palette.border_alt;
          }
          {
            name = "rake";
            text = "";
            fg = palette.bg_surface_alt;
          }
          {
            name = "patch";
            text = "";
            fg = palette.bg_surface;
          }
          {
            name = "cuh";
            text = "";
            fg = palette.border;
          }
          {
            name = "d";
            text = "";
            fg = palette.red;
          }
          {
            name = "query";
            text = "";
            fg = palette.green;
          }
          {
            name = "psb";
            text = "";
            fg = palette.bright_blue;
          }
          {
            name = "nu";
            text = ">";
            fg = palette.green;
          }
          {
            name = "mov";
            text = "";
            fg = palette.yellow;
          }
          {
            name = "lrc";
            text = "󰨖";
            fg = palette.yellow;
          }
          {
            name = "pyx";
            text = "";
            fg = palette.blue;
          }
          {
            name = "pyw";
            text = "";
            fg = palette.blue;
          }
          {
            name = "cu";
            text = "";
            fg = palette.green;
          }
          {
            name = "bazel";
            text = "";
            fg = palette.green;
          }
          {
            name = "obj";
            text = "󰆧";
            fg = palette.border;
          }
          {
            name = "pyi";
            text = "";
            fg = palette.yellow;
          }
          {
            name = "pyd";
            text = "";
            fg = palette.yellow;
          }
          {
            name = "exe";
            text = "";
            fg = palette.bg_surface;
          }
          {
            name = "pyc";
            text = "";
            fg = palette.yellow;
          }
          {
            name = "fctb";
            text = "";
            fg = palette.red;
          }
          {
            name = "part";
            text = "";
            fg = palette.cyan;
          }
          {
            name = "blade.php";
            text = "";
            fg = palette.red;
          }
          {
            name = "git";
            text = "";
            fg = palette.yellow;
          }
          {
            name = "psd";
            text = "";
            fg = palette.bright_blue;
          }
          {
            name = "qss";
            text = "";
            fg = palette.green;
          }
          {
            name = "csv";
            text = "";
            fg = palette.green;
          }
          {
            name = "psm1";
            text = "󰨊";
            fg = palette.border;
          }
          {
            name = "dconf";
            text = "";
            fg = palette.fg_subtext;
          }
          {
            name = "config.ru";
            text = "";
            fg = palette.bg_surface_alt;
          }
          {
            name = "prisma";
            text = "";
            fg = palette.fg_subtext;
          }
          {
            name = "conf";
            text = "";
            fg = palette.border;
          }
          {
            name = "clj";
            text = "";
            fg = palette.green;
          }
          {
            name = "o";
            text = "";
            fg = palette.bg_surface;
          }
          {
            name = "mp4";
            text = "";
            fg = palette.yellow;
          }
          {
            name = "cc";
            text = "";
            fg = palette.red;
          }
          {
            name = "kicad_prl";
            text = "";
            fg = palette.fg_subtext;
          }
          {
            name = "bz3";
            text = "";
            fg = palette.yellow;
          }
          {
            name = "asc";
            text = "󰦝";
            fg = palette.fg_subtext;
          }
          {
            name = "png";
            text = "";
            fg = palette.border;
          }
          {
            name = "android";
            text = "";
            fg = palette.green;
          }
          {
            name = "pm";
            text = "";
            fg = palette.bright_blue;
          }
          {
            name = "h";
            text = "";
            fg = palette.border;
          }
          {
            name = "pls";
            text = "󰲹";
            fg = palette.red;
          }
          {
            name = "ipynb";
            text = "";
            fg = palette.yellow;
          }
          {
            name = "pl";
            text = "";
            fg = palette.bright_blue;
          }
          {
            name = "ads";
            text = "";
            fg = palette.fg_subtext;
          }
          {
            name = "sqlite";
            text = "";
            fg = palette.fg_subtext;
          }
          {
            name = "pdf";
            text = "";
            fg = palette.border_alt;
          }
          {
            name = "pcm";
            text = "";
            fg = palette.fg_subtext;
          }
          {
            name = "ico";
            text = "";
            fg = palette.yellow;
          }
          {
            name = "a";
            text = "";
            fg = palette.fg_subtext;
          }
          {
            name = "R";
            text = "󰟔";
            fg = palette.fg_subtext;
          }
          {
            name = "ogg";
            text = "";
            fg = palette.fg_subtext;
          }
          {
            name = "pxd";
            text = "";
            fg = palette.blue;
          }
          {
            name = "kdenlivetitle";
            text = "";
            fg = palette.blue;
          }
          {
            name = "jxl";
            text = "";
            fg = palette.border;
          }
          {
            name = "nswag";
            text = "";
            fg = palette.green;
          }
          {
            name = "nim";
            text = "";
            fg = palette.yellow;
          }
          {
            name = "bqn";
            text = "⎉";
            fg = palette.fg_subtext;
          }
          {
            name = "cts";
            text = "";
            fg = palette.bright_blue;
          }
          {
            name = "fcparam";
            text = "";
            fg = palette.red;
          }
          {
            name = "rs";
            text = "";
            fg = palette.yellow;
          }
          {
            name = "mpp";
            text = "";
            fg = palette.bright_blue;
          }
          {
            name = "fdmdownload";
            text = "";
            fg = palette.cyan;
          }
          {
            name = "pptx";
            text = "󰈧";
            fg = palette.red;
          }
          {
            name = "jpeg";
            text = "";
            fg = palette.border;
          }
          {
            name = "bib";
            text = "󱉟";
            fg = palette.yellow;
          }
          {
            name = "vhd";
            text = "󰍛";
            fg = palette.green;
          }
          {
            name = "m";
            text = "";
            fg = palette.blue;
          }
          {
            name = "js";
            text = "";
            fg = palette.yellow;
          }
          {
            name = "eex";
            text = "";
            fg = palette.border;
          }
          {
            name = "tbc";
            text = "󰛓";
            fg = palette.border_alt;
          }
          {
            name = "astro";
            text = "";
            fg = palette.red;
          }
          {
            name = "sha224";
            text = "󰕥";
            fg = palette.border;
          }
          {
            name = "xcplayground";
            text = "";
            fg = palette.yellow;
          }
          {
            name = "el";
            text = "";
            fg = palette.border;
          }
          {
            name = "m4v";
            text = "";
            fg = palette.yellow;
          }
          {
            name = "m4a";
            text = "";
            fg = palette.bright_blue;
          }
          {
            name = "cs";
            text = "󰌛";
            fg = palette.border_alt;
          }
          {
            name = "hs";
            text = "";
            fg = palette.border;
          }
          {
            name = "tgz";
            text = "";
            fg = palette.yellow;
          }
          {
            name = "fs";
            text = "";
            fg = palette.bright_blue;
          }
          {
            name = "luau";
            text = "";
            fg = palette.blue;
          }
          {
            name = "dxf";
            text = "󰻫";
            fg = palette.green;
          }
          {
            name = "download";
            text = "";
            fg = palette.cyan;
          }
          {
            name = "cast";
            text = "";
            fg = palette.yellow;
          }
          {
            name = "qrc";
            text = "";
            fg = palette.green;
          }
          {
            name = "lua";
            text = "";
            fg = palette.bright_blue;
          }
          {
            name = "lhs";
            text = "";
            fg = palette.border;
          }
          {
            name = "md";
            text = "";
            fg = palette.fg_text;
          }
          {
            name = "leex";
            text = "";
            fg = palette.border;
          }
          {
            name = "ai";
            text = "";
            fg = palette.yellow;
          }
          {
            name = "lck";
            text = "";
            fg = palette.white;
          }
          {
            name = "kt";
            text = "";
            fg = palette.fg_subtext;
          }
          {
            name = "bicepparam";
            text = "";
            fg = palette.border;
          }
          {
            name = "hex";
            text = "";
            fg = palette.fg_subtext;
          }
          {
            name = "zig";
            text = "";
            fg = palette.yellow;
          }
          {
            name = "bzl";
            text = "";
            fg = palette.green;
          }
          {
            name = "cljc";
            text = "";
            fg = palette.green;
          }
          {
            name = "kicad_dru";
            text = "";
            fg = palette.fg_subtext;
          }
          {
            name = "fctl";
            text = "";
            fg = palette.red;
          }
          {
            name = "f#";
            text = "";
            fg = palette.bright_blue;
          }
          {
            name = "odt";
            text = "";
            fg = palette.bright_blue;
          }
          {
            name = "conda";
            text = "";
            fg = palette.green;
          }
          {
            name = "vala";
            text = "";
            fg = palette.border_alt;
          }
          {
            name = "erb";
            text = "";
            fg = palette.bg_surface_alt;
          }
          {
            name = "mp3";
            text = "";
            fg = palette.bright_blue;
          }
          {
            name = "bz2";
            text = "";
            fg = palette.yellow;
          }
          {
            name = "coffee";
            text = "";
            fg = palette.yellow;
          }
          {
            name = "cr";
            text = "";
            fg = palette.fg_subtext;
          }
          {
            name = "f90";
            text = "󱈚";
            fg = palette.border_alt;
          }
          {
            name = "jwmrc";
            text = "";
            fg = palette.fg_subtext;
          }
          {
            name = "c++";
            text = "";
            fg = palette.red;
          }
          {
            name = "fcscript";
            text = "";
            fg = palette.red;
          }
          {
            name = "fods";
            text = "";
            fg = palette.green;
          }
          {
            name = "cue";
            text = "󰲹";
            fg = palette.red;
          }
          {
            name = "srt";
            text = "󰨖";
            fg = palette.yellow;
          }
          {
            name = "info";
            text = "";
            fg = palette.yellow;
          }
          {
            name = "hh";
            text = "";
            fg = palette.border;
          }
          {
            name = "sig";
            text = "λ";
            fg = palette.yellow;
          }
          {
            name = "html";
            text = "";
            fg = palette.yellow;
          }
          {
            name = "iges";
            text = "󰻫";
            fg = palette.green;
          }
          {
            name = "kicad_wks";
            text = "";
            fg = palette.fg_subtext;
          }
          {
            name = "hbs";
            text = "";
            fg = palette.yellow;
          }
          {
            name = "fcstd";
            text = "";
            fg = palette.red;
          }
          {
            name = "gresource";
            text = "";
            fg = palette.fg_subtext;
          }
          {
            name = "sub";
            text = "󰨖";
            fg = palette.yellow;
          }
          {
            name = "ical";
            text = "";
            fg = palette.bg_surface_alt;
          }
          {
            name = "crdownload";
            text = "";
            fg = palette.cyan;
          }
          {
            name = "pub";
            text = "󰷖";
            fg = palette.yellow;
          }
          {
            name = "vue";
            text = "";
            fg = palette.green;
          }
          {
            name = "gd";
            text = "";
            fg = palette.border;
          }
          {
            name = "fsx";
            text = "";
            fg = palette.bright_blue;
          }
          {
            name = "mkv";
            text = "";
            fg = palette.yellow;
          }
          {
            name = "py";
            text = "";
            fg = palette.yellow;
          }
          {
            name = "kicad_sch";
            text = "";
            fg = palette.fg_subtext;
          }
          {
            name = "epub";
            text = "";
            fg = palette.yellow;
          }
          {
            name = "env";
            text = "";
            fg = palette.yellow;
          }
          {
            name = "magnet";
            text = "";
            fg = palette.bg_surface;
          }
          {
            name = "elf";
            text = "";
            fg = palette.bg_surface;
          }
          {
            name = "fodg";
            text = "";
            fg = palette.yellow;
          }
          {
            name = "svg";
            text = "󰜡";
            fg = palette.yellow;
          }
          {
            name = "dwg";
            text = "󰻫";
            fg = palette.green;
          }
          {
            name = "docx";
            text = "󰈬";
            fg = palette.border_alt;
          }
          {
            name = "pro";
            text = "";
            fg = palette.yellow;
          }
          {
            name = "db";
            text = "";
            fg = palette.fg_subtext;
          }
          {
            name = "rb";
            text = "";
            fg = palette.bg_surface_alt;
          }
          {
            name = "r";
            text = "󰟔";
            fg = palette.fg_subtext;
          }
          {
            name = "scss";
            text = "";
            fg = palette.red;
          }
          {
            name = "cow";
            text = "󰆚";
            fg = palette.yellow;
          }
          {
            name = "gleam";
            text = "";
            fg = palette.bright_magenta;
          }
          {
            name = "v";
            text = "󰍛";
            fg = palette.green;
          }
          {
            name = "kicad_pro";
            text = "";
            fg = palette.fg_subtext;
          }
          {
            name = "liquid";
            text = "";
            fg = palette.green;
          }
          {
            name = "zip";
            text = "";
            fg = palette.yellow;
          }
        ];
      };
    };
  };
}
