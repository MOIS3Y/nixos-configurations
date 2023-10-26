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

        -- Catppuccin Mocha Colorscheme
        bold_brightens_ansi_colors = true,
        colors = {
          foreground = "#cdd6f4",
          background = "#11111b",  -- #1e1e2e #11111b crust
          cursor_bg = "#cdd6f4",
          cursor_fg = "#cdd6f4",
          cursor_border = "#6c7086",
          selection_fg = "#1e1e2e",
          selection_bg = "#cdd6f4",
          scrollbar_thumb = "#cdd6f4",
          split = "#11111b",
          ansi = {
            "#1e1e2e",
            "#f38ba8",
            "#a6e3a1",
            "#fab387",
            "#89b4fa",
            "#cba6f7",
            "#94e2d5",
            "#e4e6e7"
          },
          brights = {
            "#6c7086",
            "#f38ba8",
            "#a6e3a1",
            "#fab387",
            "#89b4fa",
            "#cba6f7",
            "#94e2d5",
            "#f2f4f5"
          },
          indexed = { [136] = "#cdd6f4" },
          tab_bar = {
            active_tab = {
              bg_color = "#1e1e2e",
              fg_color = "#cdd6f4",
              italic = true,
            },
            inactive_tab = { bg_color = "#11111b", fg_color = "#1e1e2e" },
            inactive_tab_hover = { bg_color = "#1e1e2e", fg_color = "#cdd6f4" },
            new_tab = { bg_color = "#1e1e2e", fg_color = "#cdd6f4" },
            new_tab_hover = { bg_color = "#89b4fa", fg_color = "#11111b" },
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
        window_background_opacity = 0.4,
        window_close_confirmation = "NeverPrompt",
        window_frame = {
          active_titlebar_bg = "#11111b",
          font = font_with_fallback(font_name,
          { bold = true })
        },
      }
    '';
  };
}
