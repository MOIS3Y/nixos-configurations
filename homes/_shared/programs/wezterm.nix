# █░█░█ █▀▀ ▀█ ▀█▀ █▀▀ █▀█ █▀▄▀█ ▀
# ▀▄▀▄▀ ██▄ █▄ ░█░ ██▄ █▀▄ █░▀░█ ▄
# -- -- -- -- -- -- -- -- -- -- --

{ config, lib, ... }: let 
  inherit (config.colorScheme)
    palette;
in {
  programs.wezterm = {
    enable = lib.mkDefault config.desktop.enable;
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
          foreground = "#${palette.base05}",
          background = "#${palette.base00}",
          cursor_bg = "#${palette.base05}",
          cursor_fg = "#${palette.base05}",
          cursor_border = "#${palette.base03}",
          selection_fg = "#${palette.base01}",
          selection_bg = "#${palette.base05}",
          scrollbar_thumb = "#${palette.base05}",
          split = "#${palette.base00}",
          ansi = {
            "#${palette.base01}",
            "#${palette.base08}",
            "#${palette.base0B}",
            "#${palette.base09}",
            "#${palette.base0D}",
            "#${palette.base0E}",
            "#${palette.base0C}",
            "#${palette.base05}"
          },
          brights = {
            "#${palette.base04}",
            "#${palette.base08}",
            "#${palette.base0B}",
            "#${palette.base09}",
            "#${palette.base0D}",
            "#${palette.base0E}",
            "#${palette.base0C}",
            "#${palette.base05}"
          },
          indexed = { [136] = "#${palette.base05}" },
          tab_bar = {
            active_tab = {
              bg_color = "#${palette.base01}",
              fg_color = "#${palette.base05}",
              italic = true,
            },
            inactive_tab = { 
              bg_color = "#${palette.base00}",
              fg_color = "#${palette.base01}"
            },
            inactive_tab_hover = {
              bg_color = "#${palette.base01}",
              fg_color = "#${palette.base05}"
            },
            new_tab = {
              bg_color = "#${palette.base01}",
              fg_color = "#${palette.base05}"
            },
            new_tab_hover = {
              bg_color = "#${palette.base0D}",
              fg_color = "#${palette.base00}"
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
        window_background_opacity = 1.0,
        window_close_confirmation = "NeverPrompt",
        window_frame = {
          active_titlebar_bg = "#${palette.base00}",
          font = font_with_fallback(font_name,
          { bold = true })
        },
      }
    '';
  };
}
