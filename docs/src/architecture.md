# Architecture & Modules

The configuration is structured to maximize code reuse while allowing for host-specific customizations. This is achieved through a clear separation between **Option Definition** and **Implementation Logic**.

## Foundation

> [!NOTE]
> At its core, this project follows the standard NixOS module system. All configurations are built using native attribute sets and modules from the **NixOS Unstable** branch.

While I use custom abstractions to keep the host configurations clean, everything eventually resolves to standard NixOS options. You can find the full list of available native options at the [official NixOS Options Search](https://search.nixos.org/options).

---

## The `modules` Directory

The `modules` directory contains shared configurations that define custom options. These options act as a "public API" for each host, wrapping complex logic into simple toggles.

- **Desktop Modules:** Settings for compositors, display managers, and gaming.
- **Host Modules:** Hardware-level settings (GPU, CPU, DDCCI), boot, and system services.
- **Android Modules:** Configurations for `nix-on-droid`.

---

## How it works: Option vs. Implementation

The modularity is built on a two-step pattern.

### 1. Setting the Option (Host Level)

Each machine in `hosts/` selects its features by setting options defined in the modules. This keeps the host's `configuration.nix` declarative and high-level.

```nix
# In hosts/desktop-workstation/configuration.nix
{
  host.hardware.ddcci.enable = true; # Enable monitor control
  desktop.games.enable = true;      # Enable Steam & Gaming tools
}
```

### 2. Implementation Logic (Shared Level)

The shared modules in `hosts/_shared/` use these options to conditionally apply configurations. This is where the actual "heavy lifting" happens.

#### Example: Hardware Activation (`hosts/_shared/boot.nix`)

When `host.hardware.ddcci.enable` is set to `true`, the shared boot module automatically includes the necessary kernel drivers and modules:

```nix
# In hosts/_shared/boot.nix
{ config, lib, ... }: {
  boot = {
    extraModulePackages = [ ] 
      ++ lib.optionals config.host.hardware.ddcci.enable [ 
        config.boot.kernelPackages.ddcci-driver 
      ];

    kernelModules = [ ]
      ++ lib.optionals config.host.hardware.ddcci.enable [ 
        "ddcci_backlight" 
        "i2c-dev" 
      ];
  };
}
```

#### Example: Feature Flagging (`hosts/_shared/programs.nix`)

Similarly, the `desktop.games.enable` flag triggers the installation and configuration of multiple related programs at once:

```nix
# In hosts/_shared/programs.nix
{ config, lib, ... }: {
  programs.steam.enable = config.desktop.games.enable;
  programs.gamescope.enable = config.desktop.games.enable;
}
```

---

## Folder Structure Summary

- `modules/`: **The Definitions**. Defines *what* options exist and what types they have.
- `hosts/_shared/`: **The Logic**. Defines *how* system state changes based on those options.
- `hosts/<machine>/`: **The Consumption**. Decides *which* options to enable for a specific device.
- `homes/`: **The User**. Isolated Home Manager configurations for users, keeping system and user logic separate.
