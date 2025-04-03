# █▀▀ █▀█ █░░ █▀█ █▀█ █▀ ▀
# █▄▄ █▄█ █▄▄ █▄█ █▀▄ ▄█ ▄
# -- -- -- -- -- -- -- -- 

# Module expands the standard adding the colorSchemeName option
# After the import of the module, you can override the value of colorSchemeName
# from the current available list

{ inputs, config, pkgs, lib, ... }: {
  imports = [
    inputs.nix-colors.homeManagerModules.default  # ? add base16 color schemes
  ];
  options = {
    colorSchemeName = lib.mkOption {
      type = lib.types.enum [
        "aquarium"
        "ashes"
        "ayu_dark"
        "ayu_light"
        "bearded_arc"
        "blossom_light"
        "catppuccin_latte"
        "catppuccin_frappe"
        "catppuccin_macchiato"
        "catppuccin_mocha"
        "dracula"
        "decay"
        "everblush"
        "everforest_dark"
        "everforest_light"
        "falcon"
        "gruvbox_dark"
        "gruvbox_light"
        "kanagawa"
        "melange"
        "monokai"
        "monochrome"
        "mountain"
        "nord"
        "onedark"
        "onelight"
        "rosepine"
        "rosepine_moon"
        "rosepine_dawn"
        "rxyhn"
        "solarized"
        "sweetpastel"
        "tokyodark"
        "tokyonight"
        "yoru"
      ];
      example = "catppuccin_mocha";
      description = ''
        Name of color scheme
      '';
    };
  };
  config = {
    # ? current scheme for all devices:
    colorSchemeName = lib.mkDefault "catppuccin_mocha";
    colorScheme = (import ./schemes.nix)."${config.colorSchemeName}";
  };
}
