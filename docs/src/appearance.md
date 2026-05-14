# Appearance & Theming

> [!NOTE]
> A consistent look and feel across the entire system is a key goal of this configuration. This is achieved through a centralized theming engine.

The `modules/appearance` directory is the **single source of truth** for styling. Instead of manually configuring colors for every application, the system uses a data-driven approach powered by [matugen-nix](https://github.com/MOIS3Y/matugen-nix).

## The Theming Engine: Matugen

Matugen allows us to generate entire color schemes from a single seed color or define static, highly optimized attribute sets.

### 1. Defining the Source (Appearance Module)

In `modules/appearance/default.nix`, we set the global style and define custom color sets.

```nix
# modules/appearance/default.nix
matugen = {
  enable = true;
  mode = "dark";
  seedColor = "#89b4fa"; # Catppuccin Mocha Blue

  customColors = {
    # Custom palette for terminals and general UI
    palette = {
      dark = {
        bg_base = "#11111b";
        fg_text = "#cdd6f4";
        blue    = "#89b4fa";
        # ... other colors
      };
    };
    
    # Custom set for mdgreet (Display Manager)
    mdgreet = {
      seed = "#89b4fa";
      schemes.dark = {
        primary = "#89b4fa";
        surface = "#11111b";
        # ...
      };
    };
  };
};
```

---

## 2. Consuming Colors (Real-world Examples)

Once defined, these colors are available system-wide via `config.matugen.theme.custom`.

### Example A: Terminal Colors (Kitty)

We can map the custom `palette` directly to the terminal's color scheme. This ensures all terminal emulators share the exact same colors.

```nix
# homes/_shared/programs/kitty.nix
let
  inherit (config.matugen) mode;
  palette = config.matugen.theme.custom.palette.${mode};
in {
  programs.kitty.settings = {
    background = palette.bg_base;
    foreground = palette.fg_text;
    color4     = palette.blue; # Blue
    # ...
  };
}
```

### Example B: Display Manager (mdgreet)

The `mdgreet` tool expects a JSON configuration. We can generate this JSON on the fly using our Nix attribute sets.

```nix
# hosts/_shared/services.nix
spawn-sh-at-startup "${pkgs.extra.mdgreet} --config ${
  (pkgs.formats.toml { }).generate "mdgreet.toml" {
    appearance.theme = {
      path = "${pkgs.writeText "theme.json" (
        builtins.toJSON config.matugen.theme.custom.mdgreet
      )}";
    };
  }
}"
```

### Example C: Desktop Shell (DMS)

Similarly, the **Dank Material Shell** consumes its theme from a JSON file generated from the `custom.dms` set:

```nix
# homes/_shared/programs/dms.nix
xdg.configFile."DankMaterialShell/theme.json".text = 
  builtins.toJSON config.matugen.theme.custom.dms;
```

---

## Benefits of this Approach

- **Consistency:** Changing a single hex code in `modules/appearance` updates your terminal, display manager, and desktop shell simultaneously.
- **Portability:** By using `builtins.toJSON`, we can support any application that uses JSON or CSS variables for theming, bridging the gap between Nix and standard Linux apps.
- **Semantic Theming:** Instead of using hardcoded "blue", we use semantic names like `palette.blue` or `mdgreet.primary`, making the code easier to maintain.
