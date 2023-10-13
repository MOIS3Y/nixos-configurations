# █▀▀ █▀█ █▄░█ ▀█▀ █▀ ▀
# █▀░ █▄█ █░▀█ ░█░ ▄█ ▄
# -- -- -- -- -- -- -- -- 

{config, pkgs, ... }: {
  fonts = {
    packages = with pkgs; [
      inter
      (nerdfonts.override { fonts = [ "JetBrainsMono" ]; })
    ];
    fontconfig = {
      enable = true;
      hinting = {
        enable = true;
        style = "full";
      };
      defaultFonts.monospace = [ "JetBrainsMono"  "DejaVu Sans Mono"];
    };
  };
}
