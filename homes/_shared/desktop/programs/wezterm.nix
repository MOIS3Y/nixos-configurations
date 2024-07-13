# █░█░█ █▀▀ ▀█ ▀█▀ █▀▀ █▀█ █▀▄▀█ ▀
# ▀▄▀▄▀ ██▄ █▄ ░█░ ██▄ █▀▄ █░▀░█ ▄
# -- -- -- -- -- -- -- -- -- -- --

{ config, pkgs, ... }: {
  programs.wezterm = {
    enable = true;
    extraConfig = ''
      local wezterm = require("wezterm")

      local function font_with_fallback(name, params)
        local names = { name, "Apple Color Emoji", "azuki_font" }
        return wezterm.font_with_fallback(names, params)
      end

      local font_name = "JetBrains Mono Nerd Font"

      return {
        -- OpenGL for GPU acceleration, Software for CPU
        front_end = "OpenGL",

        -- Font config
        font = font_with_fallback(font_name),
        font_rules = {
          {
            italic = true,
            font = font_with_fallback(font_name, { italic = true }),
          },
          {
            italic = true,
            intensity = "Bold",
            font = font_with_fallback(font_name, { italic = true, bold = true }),
          },
          {
            intensity = "Bold",
            font = font_with_fallback(font_name, { bold = true }),
          },
        },
        warn_about_missing_glyphs = false,
        font_size = 11,
        line_height = 1.0,

        -- Cursor style
        default_cursor_style = "BlinkingUnderline",

        -- X11
        enable_wayland = false,

        -- Keybinds
        disable_default_key_bindings = true,
        keys = {
          {
            key = [[\]],
            mods = "CTRL|ALT",
            action = wezterm.action({
              SplitHorizontal = { domain = "CurrentPaneDomain" },
            }),
          },
          {
            key = [[\]],
            mods = "CTRL",
            action = wezterm.action({
              SplitVertical = { domain = "CurrentPaneDomain" },
            }),
          },
          {
            key = "q",
            mods = "CTRL",
            action = wezterm.action({ CloseCurrentPane = { confirm = false } }),
          },
          {
            key = "h",
            mods = "CTRL|SHIFT",
            action = wezterm.action({ ActivatePaneDirection = "Left" }),
          },
          {
            key = "l",
            mods = "CTRL|SHIFT",
            action = wezterm.action({ ActivatePaneDirection = "Right" }),
          },
          {
            key = "k",
            mods = "CTRL|SHIFT",
            action = wezterm.action({ ActivatePaneDirection = "Up" }),
          },
          {
            key = "j",
            mods = "CTRL|SHIFT",
            action = wezterm.action({ ActivatePaneDirection = "Down" }),
          },
          {
            key = "h",
            mods = "CTRL|SHIFT|ALT",
            action = wezterm.action({ AdjustPaneSize = { "Left", 1 } }),
          },
          {
            key = "l",
            mods = "CTRL|SHIFT|ALT",
            action = wezterm.action({ AdjustPaneSize = { "Right", 1 } }),
          },
          {
            key = "k",
            mods = "CTRL|SHIFT|ALT",
            action = wezterm.action({ AdjustPaneSize = { "Up", 1 } }),
          },
          {
            key = "j",
            mods = "CTRL|SHIFT|ALT",
            action = wezterm.action({ AdjustPaneSize = { "Down", 1 } }),
          },
          { -- browser-like bindings for tabbing
            key = "t",
            mods = "CTRL",
            action = wezterm.action({ SpawnTab = "CurrentPaneDomain" }),
          },
          {
            key = "w",
            mods = "CTRL",
            action = wezterm.action({ CloseCurrentTab = { confirm = false } }),
          },
          {
            key = "Tab",
            mods = "CTRL",
            action = wezterm.action({ ActivateTabRelative = 1 }),
          },
          {
            key = "Tab",
            mods = "CTRL|SHIFT",
            action = wezterm.action({ ActivateTabRelative = -1 }),
          }, -- standard copy/paste bindings
          {
            key = "x",
            mods = "CTRL",
            action = "ActivateCopyMode",
          },
          {
            key = "v",
            mods = "CTRL|SHIFT",
            action = wezterm.action({ PasteFrom = "Clipboard" }),
          },
          {
            key = "c",
            mods = "CTRL|SHIFT",
            action = wezterm.action({ CopyTo = "ClipboardAndPrimarySelection" }),
          },
        },

        -- ${config.colorScheme.name} Colorscheme
        bold_brightens_ansi_colors = true,
        colors = {
          foreground = "#${config.colorScheme.palette.base05}",
          background = "#${config.colorScheme.palette.base00}",
          cursor_bg = "#${config.colorScheme.palette.base05}",
          cursor_fg = "#${config.colorScheme.palette.base05}",
          cursor_border = "#${config.colorScheme.palette.base03}",
          selection_fg = "#${config.colorScheme.palette.base01}",
          selection_bg = "#${config.colorScheme.palette.base05}",
          scrollbar_thumb = "#${config.colorScheme.palette.base05}",
          split = "#${config.colorScheme.palette.base00}",
          ansi = {
            "#${config.colorScheme.palette.base01}",
            "#${config.colorScheme.palette.base08}",
            "#${config.colorScheme.palette.base0B}",
            "#${config.colorScheme.palette.base09}",
            "#${config.colorScheme.palette.base0D}",
            "#${config.colorScheme.palette.base0E}",
            "#${config.colorScheme.palette.base0C}",
            "#${config.colorScheme.palette.base05}"
          },
          brights = {
            "#${config.colorScheme.palette.base04}",
            "#${config.colorScheme.palette.base08}",
            "#${config.colorScheme.palette.base0B}",
            "#${config.colorScheme.palette.base09}",
            "#${config.colorScheme.palette.base0D}",
            "#${config.colorScheme.palette.base0E}",
            "#${config.colorScheme.palette.base0C}",
            "#${config.colorScheme.palette.base05}"
          },
          indexed = { [136] = "#${config.colorScheme.palette.base05}" },
          tab_bar = {
            active_tab = {
              bg_color = "#${config.colorScheme.palette.base01}",
              fg_color = "#${config.colorScheme.palette.base05}",
              italic = true,
            },
            inactive_tab = { 
              bg_color = "#${config.colorScheme.palette.base00}",
              fg_color = "#${config.colorScheme.palette.base01}"
            },
            inactive_tab_hover = {
              bg_color = "#${config.colorScheme.palette.base01}",
              fg_color = "#${config.colorScheme.palette.base05}"
            },
            new_tab = {
              bg_color = "#${config.colorScheme.palette.base01}",
              fg_color = "#${config.colorScheme.palette.base05}"
            },
            new_tab_hover = {
              bg_color = "#${config.colorScheme.palette.base0D}",
              fg_color = "#${config.colorScheme.palette.base00}"
            },
          },
        },

        -- Padding
        window_padding = {
          left = 25,
          right = 25,
          top = 25,
          bottom = 25,
        },

        -- Tab Bar
        enable_tab_bar = true,
        hide_tab_bar_if_only_one_tab = true,
        show_tab_index_in_tab_bar = false,
        tab_bar_at_bottom = true,

        -- General
        automatically_reload_config = true,
        inactive_pane_hsb = { saturation = 1.0, brightness = 1.0 },
        window_background_opacity = 0.8,
        window_close_confirmation = "NeverPrompt",
        window_frame = {
          active_titlebar_bg = "#${config.colorScheme.palette.base00}",
          font = font_with_fallback(font_name,
          { bold = true })
        },
      }
    '';
  };
}
