# █▀▀ █▀█ █▄░█ █▀ █▀█ █░░ █▀▀ ▀
# █▄▄ █▄█ █░▀█ ▄█ █▄█ █▄▄ ██▄ ▄
# -- -- -- -- -- -- -- -- -- --

{ config, pkgs, ... }: {
  console = {
    earlySetup = true;
    font = "${pkgs.terminus_font}/share/consolefonts/ter-k16n.psf.gz";  # RU
    packages = [ pkgs.terminus_font ];
    keyMap = "us";
    colors = [
      # catppucin mocha:
      "1e1e2e" "f38ba8" "a6e3a1" "fab387" "89b4fa" "cba6f7" "94e2d5" "e4e6e7"
      "6c7086" "f38ba8" "a6e3a1" "fab387" "89b4fa" "cba6f7" "94e2d5" "f2f4f5" 
    ];
  };
}
