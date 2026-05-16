# █▄░█ █ █▀█ █ ▀
# █░▀█ █ █▀▄ █ ▄
# -- -- -- -- --
# Configuration for the Niri scrollable tiling compositor.

{
  config,
  lib,
  pkgs,
  ...
}:

let
  inherit (lib)
    concatStringsSep
    mapAttrsToList
    mkIf
    mkOption
    optionalString
    types
    ;

  inherit (config.matugen) mode;
  palette = config.matugen.theme.custom.palette.${mode};

  cfg = config.programs.niri;
  homeDir = config.home.homeDirectory;

  dmsIncludes = [
    "binds"
    "colors"
    "cursor"
    "outputs"
  ];

  mkIncludes =
    fmt:
    concatStringsSep (if fmt == null then " " else "\n") (
      map (name: if fmt == null then "${name}.kdl" else fmt name) dmsIncludes
    );

  includes = mkIncludes (name: "include \"dms/${name}.kdl\"");

  mkMonitor = name: cfg: ''
    output "${name}" {
      ${optionalString (cfg.focus-at-startup or false) "focus-at-startup"}
      mode "${cfg.mode}"
      scale ${toString (cfg.scale or 1)}
      position x=${toString cfg.position.x} y=${toString cfg.position.y}
    }
  '';
  monitors = concatStringsSep "\n" (mapAttrsToList mkMonitor config.desktop.devices.monitors);
in
{
  options.programs.niri = {
    enable = mkOption {
      type = types.bool;
      default = true;
      description = "Enable niri config generation.";
    };
    settings = mkOption {
      type = types.lines;
      default = "";
      description = "Raw configuration string for niri (config.kdl).";
    };
    backup = mkOption {
      type = types.bool;
      default = false;
      description = "Whether to backup existing config before replacing.";
    };
  };

  config = {
    programs.niri = {
      enable = true;
      backup = false;
      settings = ''
        // --- ENVIRONMENT VARIABLES

        environment {
          ELECTRON_OZONE_PLATFORM_HINT "auto"
          XDG_CURRENT_DESKTOP "niri"
          QT_QPA_PLATFORM "wayland"
          QT_QPA_PLATFORMTHEME "gtk3"
          QT_QPA_PLATFORMTHEME_QT6 "gtk3"
        }

        // --- INPUT DEVICES (Keyboard, Mouse, Touchpad)

        input {
          keyboard {
            xkb {
              // Layouts and switching via Alt+Shift
              layout "us,ru"
              options "grp:alt_shift_toggle"
            }
            numlock
          }

          touchpad {
            tap
            drag true
            natural-scroll
            scroll-method "two-finger"
          }

          // Common mouse settings
          focus-follows-mouse max-scroll-amount="0%"
          warp-mouse-to-focus
        }

        // --- OUTPUT CONFIGURATION (Monitors)

        ${monitors}

        // --- GENERAL LAYOUT SETTINGS

        layout {
          gaps 16
          center-focused-column "never"
          default-column-display "normal"

          // Preset widths for Mod+R
          preset-column-widths {
            proportion 0.33333
            proportion 0.5
            proportion 0.66667
          }

          // Default width for new windows
          default-column-width { proportion 0.5; }

          focus-ring {
            width 2
          }

          border {
            off
            width 2
          }

          shadow {
            on
            softness 30
            spread 5
            offset x=0 y=5
          }

          // Outer margins to see peek of adjacent windows
          struts {
            left 16
            right 16
          }
        }

        // --- VISUAL EFFECTS (Blur & Overview)

        // Global blur quality settings
        blur {
          passes 3
          offset 0.6
          noise 0.03
          saturation 1.2
        }

        // Zoom-out workspace viewer
        overview {
          zoom 0.5
          backdrop-color "${palette.bg_base}"
          workspace-shadow {
            on
            softness 40
            spread 10
            offset x=0 y=10
            color "${palette.bg_base}70"
          }
        }

        // --- WINDOW RULES (Behavior & Styles)

        // Global defaults for all windows: Rounded corners and clipped CSD
        window-rule {
          geometry-corner-radius 12
          clip-to-geometry true
          tiled-state true
          draw-border-with-background false
        }

        // Terminals: Translucency and Blur
        window-rule {
          match app-id=r#"^Alacritty$"#
          match app-id=r#"^kitty$"#
          match app-id=r#"^org\.wezfurlong\.wezterm$"#
          opacity 0.9
          background-effect {
            blur true
            xray true
          }
        }

        // Browsers & Steam: Full width and 'main' workspace
        window-rule {
          match app-id=r#"^firefox$"#
          match app-id=r#"^google-chrome$"#
          match app-id=r#"^steam$"#
          default-column-width { proportion 1.0; }
          open-focused true
        }

        // Code Editors: Full width and 'edit' workspace
        window-rule {
          match app-id=r#"^dev\.zed\.Zed$"#
          match app-id=r#"^code$"#
          default-column-width { proportion 1.0; }
          open-focused true
        }

        // Media Players: Translucency and Blur
        window-rule {
          match app-id=r#"^feishin$"#
          match app-id=r#"^space\.rirusha\.Cassette$"#
          match app-id=r#"^io\.bassi\.Amberol$"#
          opacity 0.9
          background-effect {
            blur true
            xray true
          }
        }

        // Communication: 'chat' workspace
        window-rule {
          match app-id=r#"^Mattermost$"#
          match app-id=r#"^org\.telegram\.desktop$"#
          open-focused true
        }

        // Utils
        window-rule {
          match app-id=r#"^org\.gnome\.Calculator$"#
          open-floating true
          open-focused true
        }

        // --- GESTURES

        gestures {
          dnd-edge-view-scroll {
            trigger-width 50
            delay-ms 150
            max-speed 2000
          }
          dnd-edge-workspace-switch {
            trigger-height 50
            delay-ms 150
            max-speed 2000
          }
          hot-corners {
            top-left
          }
        }

        // --- KEYBOARD SHORTCUTS (Binds)

        binds {
          // System Actions
          Mod+Shift+Slash { show-hotkey-overlay; }
          Mod+Escape allow-inhibiting=false { toggle-keyboard-shortcuts-inhibit; }
          Mod+Shift+E { quit; }
          Ctrl+Alt+Delete { quit; }
          Mod+Shift+P { power-off-monitors; }

          // App Launchers
          Mod+Return hotkey-overlay-title="Open a Terminal: Kitty" { spawn "kitty"; }
          Mod+T hotkey-overlay-title="Open a Terminal: Alacritty" { spawn "alacritty"; }
          Mod+B hotkey-overlay-title="Run an Application: Firefox" { spawn "firefox"; }
          Mod+M repeat=false hotkey-overlay-title="App Launcher: Toggle" {
            spawn "dms" "ipc" "call" "spotlight" "toggle"
          }

          // Security
          Mod+Alt+L hotkey-overlay-title="Lock Screen" {
            spawn "dms" "ipc" "call" "lock" "lock"
          }

          // Audio Control
          XF86AudioRaiseVolume allow-when-locked=true {
            spawn "dms" "ipc" "call" "audio" "increment" "10"
          }
          XF86AudioLowerVolume allow-when-locked=true {
            spawn "dms" "ipc" "call" "audio" "decrement" "10"
          }
          XF86AudioMute allow-when-locked=true {
            spawn "dms" "ipc" "call" "audio" "mute"
          }
          XF86AudioMicMute allow-when-locked=true {
            spawn "dms" "ipc" "call" "audio" "micmute"
          }

          // Media Control
          XF86AudioPlay allow-when-locked=true {
            spawn "dms" "ipc" "call" "mpris" "playPause"
          }
          XF86AudioStop allow-when-locked=true {
            spawn "dms" "ipc" "call" "mpris" "stop"
          }
          XF86AudioPrev allow-when-locked=true {
            spawn "dms" "ipc" "call" "mpris" "previous"
          }
          XF86AudioNext allow-when-locked=true {
            spawn "dms" "ipc" "call" "mpris" "next"
          }

          // Brightness Control
          XF86MonBrightnessUp allow-when-locked=true {
            spawn "dms" "ipc" "call" "brightness" "increment" "10" ""
          }
          XF86MonBrightnessDown allow-when-locked=true {
            spawn "dms" "ipc" "call" "brightness" "decrement" "10" ""
          }

          // Layout & Windows
          Mod+O repeat=false { toggle-overview; }
          Mod+Q repeat=false { close-window; }
          Mod+V              { toggle-window-floating; }
          Mod+Shift+V { switch-focus-between-floating-and-tiling; }
          Mod+W       { toggle-column-tabbed-display; }

          // Navigation: Flow across columns and workspaces
          Mod+Left  { focus-column-left; }
          Mod+Down  { focus-window-or-workspace-down; }
          Mod+Up    { focus-window-or-workspace-up; }
          Mod+Right { focus-column-right; }
          Mod+H     { focus-column-left; }
          Mod+J     { focus-window-or-workspace-down; }
          Mod+K     { focus-window-or-workspace-up; }
          Mod+L     { focus-column-right; }

          // Movement: Move windows/columns and flow to monitors/workspaces
          Mod+Shift+Left  { move-column-left-or-to-monitor-left; }
          Mod+Shift+Down  { move-window-down-or-to-workspace-down; }
          Mod+Shift+Up    { move-window-up-or-to-workspace-up; }
          Mod+Shift+Right { move-column-right-or-to-monitor-right; }
          Mod+Shift+H     { move-column-left-or-to-monitor-left; }
          Mod+Shift+J     { move-window-down-or-to-workspace-down; }
          Mod+Shift+K     { move-window-up-or-to-workspace-up; }
          Mod+Shift+L     { move-column-right-or-to-monitor-right; }

          // Workspace Movement
          Mod+Ctrl+Left  { move-workspace-to-monitor-left; }
          Mod+Ctrl+Down  { move-workspace-down; }
          Mod+Ctrl+Up    { move-workspace-up; }
          Mod+Ctrl+Right { move-workspace-to-monitor-right; }
          Mod+Ctrl+H     { move-workspace-to-monitor-left; }
          Mod+Ctrl+J     { move-workspace-down; }
          Mod+Ctrl+K     { move-workspace-up; }
          Mod+Ctrl+L     { move-workspace-to-monitor-right; }

          // Monitor Focus
          Super+Comma  { focus-monitor-left; }
          Super+Period { focus-monitor-right; }

          Mod+Home      { focus-column-first; }
          Mod+End       { focus-column-last; }
          Mod+Ctrl+Home { move-column-to-first; }
          Mod+Ctrl+End  { move-column-to-last; }

          // Workspace Navigation
          Mod+Page_Down      { focus-workspace-down; }
          Mod+Page_Up        { focus-workspace-up; }
          Mod+U              { focus-workspace-down; }
          Mod+I              { focus-workspace-up; }
          Mod+Ctrl+Page_Down { move-column-to-workspace-down; }
          Mod+Ctrl+Page_Up   { move-column-to-workspace-up; }
          Mod+Ctrl+U         { move-column-to-workspace-down; }
          Mod+Ctrl+I         { move-column-to-workspace-up; }

          Mod+Shift+Page_Down { move-workspace-down; }
          Mod+Shift+Page_Up   { move-workspace-up; }
          Mod+Shift+U         { move-workspace-down; }
          Mod+Shift+I         { move-workspace-up; }

          // Mouse Wheel Binds
          Mod+WheelScrollDown      cooldown-ms=150 { focus-workspace-down; }
          Mod+WheelScrollUp        cooldown-ms=150 { focus-workspace-up; }
          Mod+Ctrl+WheelScrollDown cooldown-ms=150 { move-column-to-workspace-down; }
          Mod+Ctrl+WheelScrollUp   cooldown-ms=150 { move-column-to-workspace-up; }

          Mod+WheelScrollRight      { focus-column-right; }
          Mod+WheelScrollLeft       { focus-column-left; }
          Mod+Ctrl+WheelScrollRight { move-column-right; }
          Mod+Ctrl+WheelScrollLeft  { move-column-left; }

          Mod+Shift+WheelScrollDown      { focus-column-right; }
          Mod+Shift+WheelScrollUp        { focus-column-left; }
          Mod+Ctrl+Shift+WheelScrollDown { move-column-right; }
          Mod+Ctrl+Shift+WheelScrollUp   { move-column-left; }

          // Workspace by Index
          Mod+1 { focus-workspace 1; }
          Mod+2 { focus-workspace 2; }
          Mod+3 { focus-workspace 3; }
          Mod+4 { focus-workspace 4; }
          Mod+5 { focus-workspace 5; }
          Mod+6 { focus-workspace 6; }
          Mod+7 { focus-workspace 7; }
          Mod+8 { focus-workspace 8; }
          Mod+9 { focus-workspace 9; }
          Mod+Shift+1 { move-column-to-workspace 1; }
          Mod+Shift+2 { move-column-to-workspace 2; }
          Mod+Shift+3 { move-column-to-workspace 3; }
          Mod+Shift+4 { move-column-to-workspace 4; }
          Mod+Shift+5 { move-column-to-workspace 5; }
          Mod+Shift+6 { move-column-to-workspace 6; }
          Mod+Shift+7 { move-column-to-workspace 7; }
          Mod+Shift+8 { move-column-to-workspace 8; }
          Mod+Shift+9 { move-column-to-workspace 9; }

          // Column Management
          Mod+BracketLeft  { consume-or-expel-window-left; }
          Mod+BracketRight { consume-or-expel-window-right; }
          Mod+Shift+BracketLeft  { consume-window-into-column; }
          Mod+Shift+BracketRight { expel-window-from-column; }

          // Sizing Actions
          Mod+R       { switch-preset-column-width; }
          Mod+Shift+R { switch-preset-window-height; }
          Mod+Ctrl+R  { reset-window-height; }
          Mod+F       { maximize-column; }
          Mod+Shift+F { fullscreen-window; }
          Mod+Ctrl+F  { expand-column-to-available-width; }
          Mod+C       { center-column; }
          Mod+Ctrl+C  { center-visible-columns; }

          Mod+Minus { set-column-width "-10%"; }
          Mod+Equal { set-column-width "+10%"; }
          Mod+Shift+Minus { set-window-height "-10%"; }
          Mod+Shift+Equal { set-window-height "+10%"; }

          // Screenshots
          Print      { spawn "dms" "screenshot"; }
          Mod+Print  { spawn-sh "dms screenshot region --stdout | swappy -f -"; }
          Ctrl+Print { screenshot-screen; }
          Alt+Print  { screenshot-window; }
        }

        // --- MISCELLANEOUS

        screenshot-path "~/Pictures/Screenshots/%Y-%m-%d-%H-%M-%S.png"
        prefer-no-csd

        hotkey-overlay { skip-at-startup; }

        // --- DANK MATERIAL SHELL (DMS)

        ${includes}
      '';
    };

    # Activation script to handle DMS files and config copy/backup
    home.activation.niri-setup = mkIf cfg.enable (
      lib.hm.dag.entryAfter [ "writeBoundary" ] ''
        setup_dms() {
          local dms_dir="${homeDir}/.config/niri/dms"
          $DRY_RUN_CMD mkdir -p $VERBOSE_ARG "$dms_dir"

          for f in ${mkIncludes null}; do
            if [ ! -f "$dms_dir/$f" ]; then
              $DRY_RUN_CMD touch $VERBOSE_ARG "$dms_dir/$f"
            fi
          done
        }

        backup_and_install_config() {
          local src_path="${pkgs.writeText "niri-config.kdl" cfg.settings}"
          local dst_path="${homeDir}/.config/niri/config.kdl"
          local backup_enabled=${if cfg.backup then "true" else "false"}

          if [ -e "$dst_path" ] || [ -L "$dst_path" ]; then
            if [ "$backup_enabled" = "true" ]; then
              local timestamp
              timestamp=$(date +%s)
              $DRY_RUN_CMD cp $VERBOSE_ARG "$dst_path" "${homeDir}/.config/niri/config.$timestamp.bak.kdl"
            fi
            $DRY_RUN_CMD rm -f $VERBOSE_ARG "$dst_path"
          fi

          $DRY_RUN_CMD cp $VERBOSE_ARG "$src_path" "$dst_path"
          $DRY_RUN_CMD chmod $VERBOSE_ARG +w "$dst_path"
        }

        setup_dms
        backup_and_install_config
      ''
    );
  };
}
