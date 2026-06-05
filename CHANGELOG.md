# Changelog

All notable changes to this project will be documented in this file.

## [26.06.0] - 2026-06-05

### 🚀 Features

- *(hosts/polaris)* Add new Polaris VPS configuration and secrets
- *(vps-polaris)* Add xraymgr utility

### 🐛 Bug Fixes

- *(steam)* Disable gamescope capSysNice to resolve bubblewrap error
- *(flake)* Use correct polaris host configuration path
- *(ssh)* Remove legacy nix-on-droid matchers

### 🛠️ Configuration

- *(xdg)* Set Nautilus as primary file manager for directories
- *(yazi)* Implement dynamic matugen theme and update config syntax
- *(secrets)* Update host-specific encrypted values
- *(ssh)* Update hosts and manage secrets

### 🚜 Refactor

- *(ssh)* Migrate from deprecated matchBlocks to settings

### ⚙️ Miscellaneous Tasks

- *(docs)* Trigger docs deployment on CHANGELOG.md changes
- *(secrets)* Update desktop secrets


## [26.05.1] - 2026-05-16

### 🛠️ Configuration

- *(niri)* Migrate to brightnessctl and refine touchpad settings
- *(niri)* Migrate media and brightness controls to dms IPC

### 📚 Documentation

- *(style)* Add docstrings and clean up ASCII headers


## [26.05.0] - 2026-05-15

### Changed
- **nix**: Transitioned to formal versioning (`YY.MM.Patch`) for stable configurations.
- **nix**: Optimized build reliability by removing global Cachix substituters.
- **nix**: Refactored Flake inputs to strictly follow system `nixpkgs`.

### Added
- **dev**: Integrated `git-cliff` for automated changelog management.
- **docs**: Linked the project changelog directly into the `mdbook` documentation.

### Project State (Initial Versioning)
- **WM/Compositor**: Niri (Wayland tiling compositor).
- **Desktop Shell**: Dank Material Shell (DMS) with Material Design 3.
- **Login**: greetd + custom `mdgreet` (Material Design greeter).
- **Theming**: Unified Catppuccin Mocha aesthetic powered by `matugen`.
- **Secrets**: Encrypted data management via `sops-nix`.
- **Infrastructure**: Modular NixOS & Home Manager setup for multiple devices.
