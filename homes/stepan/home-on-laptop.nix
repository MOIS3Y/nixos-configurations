# █░█ █▀█ █▀▄▀█ █▀▀ ▄▄ █▀█ █▄░█ ▄▄ █░░ ▄▀█ █▀█ ▀█▀ █▀█ █▀█ ▀
# █▀█ █▄█ █░▀░█ ██▄ ░░ █▄█ █░▀█ ░░ █▄▄ █▀█ █▀▀ ░█░ █▄█ █▀▀ ▄
# -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -

{ config, ... }: {
  imports = [
    # Custom modules:
    ../../modules/colors
    ../../modules/desktop
    # Shared configuration:
    ../_shared/desktop
    # Common users' home configuration:
    ./common.nix
  ];

  desktop = {
    preset = "laptop";
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
