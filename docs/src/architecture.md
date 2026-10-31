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
- **Android Modules:** Configurations for `nix-on-droid`.

---

## How it works: Option vs. Implementation

The modularity is built on a two-step pattern.

### 1. Shared Defaults and Host Overrides

Hardware and system services use native NixOS options directly. Shared modules set common defaults with `lib.mkDefault`; each host overrides them in its own `configuration.nix` with ordinary assignments. `lib.mkForce` is reserved for overriding stronger definitions or replacing merged lists.

```nix
# In hosts/_shared/hardware.nix
{ lib, ... }: {
  hardware.bluetooth.enable = lib.mkDefault true;
}

# In a host's configuration.nix, when Bluetooth is not needed
{
  hardware.bluetooth.enable = false;
}
```

The desktop hosts share enabled Bluetooth, graphics, Docker, and libvirt. Docker uses `enableOnBoot = false` for socket activation. Libvirt's service and guest restoration are removed from boot targets while its sockets remain enabled.

GRUB defaults to the NixOS theme. Each host selects its own theme with `boot.loader.grub.theme`; the shared splash image follows the selected theme.

### 2. Device-Specific Hardware

Settings such as AMD overdrive, LACT, CoolerControl, and DDC/CI are enabled explicitly on the workstation. DDC/CI drivers and udev rules are kept together in its `configuration.nix`:

```nix
{ config, pkgs, ... }: {
  boot.extraModulePackages = [ config.boot.kernelPackages.ddcci-driver ];
  boot.kernelModules = [ "ddcci_backlight" "i2c-dev" ];
  services.udev.packages = [ pkgs.ddcutil ];
}
```

Custom `desktop` options remain useful where one feature configures several related programs.

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
- `hosts/_shared/`: **The Defaults and Logic**. Sets native NixOS defaults and implements desktop features.
- `hosts/<machine>/`: **The Host Settings**. Overrides shared defaults and configures device-specific hardware.
- `homes/`: **The User**. Isolated Home Manager configurations for users, keeping system and user logic separate.
