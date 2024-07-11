# █░█ ▀█▀ █ █░░ █▀ ▀
# █▄█ ░█░ █ █▄▄ ▄█ ▄
# -- -- -- -- -- -- 

{ pkgs, ... }: with pkgs; with pkgs.lib; {
  # B
  bash = "${getExe bash}";
  brightnessctl = "${getExe brightnessctl}";
  # C
  cat = "${coreutils}/bin/cat";
  # D
  ddcutil = "${getExe ddcutil}";
  dunstify = "${dunst}/bin/dunstify";
  # E
  emmet-ls = "${getExe emmet-ls}";
  # F
  file = "${getExe file}";
  firefox = "${getExe firefox}";
  # G
  gnome-calculator = "${gnome-calculator}/bin/gnome-calculator";
  # H
  hyprctl = "${hyprland}/bin/hyprctl";
  hyprlock = "${getExe hyprlock}";
  # K
  kitty = "${getExe kitty}";
  # L
  lightctl = "${avizo}/bin/lightctl";
  # N
  nautilus = "${getExe nautilus}";
  nil = "${getExe nil}";
  notify-send = "${getExe pkgs.libnotify}";
  # P
  pamixer = "${getExe pkgs.pamixer}";
  paplay = "${pulseaudio}/bin/paplay";
  pgrep = "${procps}/bin/pgrep";
  pistol = "${getExe pistol}";
  pkill = "${procps}/bin/pkill";
  pylsp = "${getExe python311Packages.python-lsp-server}";
  # R
  rg = "${getExe ripgrep}";
  # S
  seq = "${coreutils}/bin/seq";
  sleep = "${coreutils}/bin/sleep";
  ssh-add = "${openssh}/bin/ssh-add";
  swaylock = "${getExe swaylock-effects}";
  swaync-client = "${swaynotificationcenter}/bin/swaync-client";
  systemctl = "${systemd}/bin/systemctl";
  # V
  vault = "${getExe vault}";
  volumectl = "${avizo}/bin/volumectl";
  vscode = "${getExe vscode}";
  # W
  wlogout = "${getExe wlogout}";
  wayland-logout = "${getExe wayland-logout}";
  wezterm = "${getExe wezterm}";
  wofi = "${getExe wofi}";
  # X
  xdragon = "${getExe xdragon}";
  xss-lock = "${getExe xss-lock}";
  xset = "${xorg.xset}/bin/xset";
}
