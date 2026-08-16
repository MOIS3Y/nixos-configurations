# █▄░█ █ ▀▄▀ █▀█ █▄▀ █▀▀ █▀ ▀
# █░▀█ █ █░█ █▀▀ █░█ █▄█ ▄█ ▄
# -- -- -- -- -- -- -- -- --
# Sets up nixpkgs overlays and unfree config.

{
  inputs,
  pkgs,
  ...
}:
let
  system = pkgs.stdenv.hostPlatform.system;
in
{
  nixpkgs = {
    config = {
      allowUnfree = true;
    };
    overlays = [
      (final: prev: {
        extra = {
          aladdin-nix = inputs.aladdin-nix.packages.${system}.default;
          assets4nix = inputs.assets4nix.packages.${system}.default;
          dion-nix = inputs.dion-nix.packages.${system}.default;
          nvchad = inputs.nix4nvchad.packages.${system}.default;
          mdgreet = inputs.mdgreet.packages.${system}.default;
        };

        # FIXME: Remove when python-lsp-ruff's tests support the current Ruff.
        # see: https://github.com/NixOS/nixpkgs/issues/548631
        pythonPackagesExtensions = prev.pythonPackagesExtensions ++ [
          (pythonFinal: pythonPrev: {
            python-lsp-ruff = pythonPrev.python-lsp-ruff.overridePythonAttrs (old: {
              disabledTests = (old.disabledTests or [ ]) ++ [
                "test_ruff_settings"
                "test_notebook_input"
              ];
            });
          })
        ];
      })
    ];
  };
}
