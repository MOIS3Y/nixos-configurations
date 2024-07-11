# █▀▄▀█ █▀█ █▀▄ █░█ █░░ █▀▀ ▀
# █░▀░█ █▄█ █▄▀ █▄█ █▄▄ ██▄ ▄
# -- -- -- --- -- -- -- -- --

{ inputs, config, pkgs, lib, ... }: {
  
  imports = [
    inputs.nix-colors.homeManagerModules.default  # ? add base16 color schemes
  ];

  options = {
    colorSchemeName = lib.mkOption {
      default = "catppuccin_mocha";
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
        Name of color sheme
      '';
    };
  };
  
  config = {
    colorScheme = (import ./schemes.nix)."${config.colorSchemeName}";
  };
}
