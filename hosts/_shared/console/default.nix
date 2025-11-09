# █▀▀ █▀█ █▄░█ █▀ █▀█ █░░ █▀▀ ▀
# █▄▄ █▄█ █░▀█ ▄█ █▄█ █▄▄ ██▄ ▄
# -- -- -- -- -- -- -- -- -- --

{ config, pkgs, ... }: {
  console = {
    earlySetup = true;
    font = "ter-k16n";  # RU
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
