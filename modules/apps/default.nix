# ▄▀█ █▀█ █▀█ █▀ ▀
# █▀█ █▀▀ █▀▀ ▄█ ▄
# -- -- -- -- -- -

{ config, pkgs, ...}: {
  imports = [
    ./module.nix
  ];
  # ? current apps for all desktop devices:
  apps = {
    terminal = config.apps.utils.kitty;
    spare-terminal = config.apps.utils.wezterm;
    browser = config.apps.utils.firefox;
    filemanager = config.apps.utils.nautilus;
    launcher = config.apps.utils.wofi;
    lockscreen = config.apps.utils.hyprlock;
    visual-text-editor = config.apps.utils.vscode;
  };
}
