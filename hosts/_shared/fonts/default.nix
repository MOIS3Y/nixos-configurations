# █▀▀ █▀█ █▄░█ ▀█▀ █▀ ▀
# █▀░ █▄█ █░▀█ ░█░ ▄█ ▄
# -- -- -- -- -- -- -- 

{config, pkgs, ... }: {
  fonts = {
    packages = with pkgs; [
      inter
      liberation_ttf
      noto-fonts-emoji
      nerd-fonts.jetbrains-mono
      roboto
      ubuntu_font_family
    ];
    fontconfig = {
      enable = true;
      hinting = {
        enable = true;
        style = "full";
      };
      allowBitmaps = false;
      subpixel.lcdfilter = "default";
      defaultFonts = {
        emoji = [ "Noto Color Emoji" ];
        sansSerif = [ "Ubuntu" ];  # default DejaVu Sans
        serif = [ "Ubuntu" ];  # default DejaVu Serif
        monospace = [ "JetBrainsMono" ];
      };
    };
  };
}
