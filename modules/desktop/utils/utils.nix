# █░█ ▀█▀ █ █░░ █▀ ▀
# █▄█ ░█░ █ █▄▄ ▄█ ▄
# -- -- -- -- -- -- 

{ pkgs, lib, ... }: {
  # A
  awk = "${pkgs.gawk}/bin/awk";
  alacritty = "${lib.getExe pkgs.alacritty}";
  # B
  bash = "${lib.getExe pkgs.bash}";
  btm = "${lib.getExe pkgs.bottom}";
  brightnessctl = "${lib.getExe pkgs.brightnessctl}";
  # C
  cat = "${pkgs.coreutils}/bin/cat";
  # D
  ddcutil = "${lib.getExe pkgs.ddcutil}";
  dunstify = "${pkgs.dunst}/bin/dunstify";
  # E
  emmet-ls = "${lib.getExe pkgs.emmet-ls}";
  # F
  file = "${lib.getExe pkgs.file}";
  firefox = "${lib.getExe pkgs.firefox}";
  # G
  gnome-calculator = "${pkgs.gnome-calculator}/bin/gnome-calculator";
  gnome-disks = "${lib.getExe pkgs.gnome-disk-utility}";
  gnome-system-monitor = "${lib.getExe pkgs.gnome-system-monitor}";
  gnome-calendar = "${lib.getExe pkgs.gnome-calendar}";
  grim = "${lib.getExe pkgs.grim}";
  # H
  htop = "${lib.getExe pkgs.htop}";
  hyprctl = "${pkgs.hyprland}/bin/hyprctl";
  hyprlock = "${lib.getExe pkgs.hyprlock}";
  # I
  i3lock-run = "${pkgs.extra.i3lock-run}/bin/i3lock-run";
  # K
  kitty = "${lib.getExe pkgs.kitty}";
  # L
  lightctl = "${pkgs.avizo}/bin/lightctl";
  loginctl = "${pkgs.systemd}/bin/loginctl";
  # M
  mkfifo = "${pkgs.coreutils}/bin/mkfifo";
  # N
  nautilus = "${lib.getExe pkgs.nautilus}";
  nil = "${lib.getExe pkgs.nil}";
  notify-send = "${lib.getExe pkgs.libnotify}";
  # P
  pamixer = "${lib.getExe pkgs.pamixer}";
  paplay = "${pkgs.pulseaudio}/bin/paplay";
  pavucontrol = "${lib.getExe pkgs.pavucontrol}";
  pgrep = "${pkgs.procps}/bin/pgrep";
  pistol = "${lib.getExe pkgs.pistol}";
  pkill = "${pkgs.procps}/bin/pkill";
  pylsp = "${lib.getExe pkgs.python311Packages.python-lsp-server}";
  # R
  rg = "${lib.getExe pkgs.ripgrep}";
  rm = "${pkgs.coreutils}/bin/rm";
  # S
  seq = "${pkgs.coreutils}/bin/seq";
  sleep = "${pkgs.coreutils}/bin/sleep";
  slurp = "${lib.getExe pkgs.slurp}";
  # ssh-add = "${pkgs.openssh}/bin/ssh-add";
  swappy = "${lib.getExe pkgs.swappy}";
  swaylock = "${lib.getExe pkgs.swaylock-effects}";
  swaync-client = "${pkgs.swaynotificationcenter}/bin/swaync-client";
  systemctl = "${pkgs.systemd}/bin/systemctl";
  # V
  vault = "${lib.getExe pkgs.vault}";
  volumectl = "${pkgs.avizo}/bin/volumectl";
  vscode = "${lib.getExe pkgs.vscode}";
  # W
  wlogout = "${lib.getExe pkgs.wlogout}";
  wayland-logout = "${lib.getExe pkgs.wayland-logout}";
  wezterm = "${lib.getExe pkgs.wezterm}";
  wofi = "${lib.getExe pkgs.wofi}";
  # X
  xdragon = "${lib.getExe pkgs.xdragon}";
  xrandr = "${lib.getExe pkgs.xorg.xrandr}";
  xss-lock = "${lib.getExe pkgs.xss-lock}";
  xset = "${lib.getExe pkgs.xorg.xset}";
}
