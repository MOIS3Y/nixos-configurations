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
      "${config.colorScheme.palette.base00}"
      "${config.colorScheme.palette.base08}"
      "${config.colorScheme.palette.base0B}"
      "${config.colorScheme.palette.base09}"
      "${config.colorScheme.palette.base0D}"
      "${config.colorScheme.palette.base0E}"
      "${config.colorScheme.palette.base0C}"
      "${config.colorScheme.palette.base05}"

      "${config.colorScheme.palette.base03}"
      "${config.colorScheme.palette.base08}"
      "${config.colorScheme.palette.base0B}"
      "${config.colorScheme.palette.base09}"
      "${config.colorScheme.palette.base0D}"
      "${config.colorScheme.palette.base0E}"
      "${config.colorScheme.palette.base0C}"
      "${config.colorScheme.palette.base05}"
    ];
  };
}
