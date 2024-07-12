# █▀▀ █▀█ █▄░█ █▀ █▀█ █░░ █▀▀ ▀
# █▄▄ █▄█ █░▀█ ▄█ █▄█ █▄▄ ██▄ ▄
# -- -- -- -- -- -- -- -- -- --

{ config, pkgs, ... }: {
  console = {
    earlySetup = true;
    font = "${pkgs.terminus_font}/share/consolefonts/ter-k16n.psf.gz";  # RU
    packages = [ pkgs.terminus_font ];
    keyMap = "us";
    colors = with config.colorScheme.palette; [
      "${base00}"
      "${base08}"
      "${base0B}"
      "${base09}"
      "${base0D}"
      "${base0E}"
      "${base0C}"
      "${base05}"

      "${base03}"
      "${base08}"
      "${base0B}"
      "${base09}"
      "${base0D}"
      "${base0E}"
      "${base0C}"
      "${base05}"
    ];
  };
}
