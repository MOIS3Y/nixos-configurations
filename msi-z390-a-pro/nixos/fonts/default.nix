# █▀▀ █▀█ █▄░█ ▀█▀ █▀ ▀
# █▀░ █▄█ █░▀█ ░█░ ▄█ ▄
# -- -- -- -- -- -- -- 

{config, pkgs, ... }: {
  fonts = {
    packages = with pkgs; [
      inter
      liberation_ttf
      noto-fonts-emoji
      (nerdfonts.override { fonts = [ "JetBrainsMono" ]; })
      roboto
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
        sansSerif = [ "DejaVu Sans" ];  # default
        serif = [ "DejaVu Serif" ];  # default
        monospace = [ "JetBrainsMono" ];
      };
    };
  };
}
