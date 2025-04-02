# █░█ █▀█ █▀▄▀█ █▀▀ ▄▄ █▀█ █▄░█ ▄▄ █░█░█ █▀█ █▀█ █▄▀ █▀ ▀█▀ ▄▀█ ▀█▀ █ █▀█ █▄░█ ▀
# █▀█ █▄█ █░▀░█ ██▄ ░░ █▄█ █░▀█ ░░ ▀▄▀▄▀ █▄█ █▀▄ █░█ ▄█ ░█░ █▀█ ░█░ █ █▄█ █░▀█ ▄
# -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- 

{ config, ... }: {
  imports = [
    # Custom modules:
    ../../modules/assets
    ../../modules/colors
    ../../modules/cursor
    ../../modules/desktop
    # Shared configuration:
    ../_shared/desktop
    # Common users' home configuration:
    ./common.nix
  ];

  desktop = {
    preset = "workstation";
    apps = with config.desktop.utils; {
      terminal = kitty;
      spare-terminal = alacritty;
      browser = firefox;
      filemanager = nautilus;
      launcher = wofi;
      lockscreen = hyprlock;
      visual-text-editor = vscode;
    };
  };
}
