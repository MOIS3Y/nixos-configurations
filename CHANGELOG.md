# Changelog

All notable changes to this project will be documented in this file.

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
