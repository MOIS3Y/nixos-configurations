# █▀█ ▄▀█ █▀▄▀█ ▀
# █▀▀ █▀█ █░▀░█ ▄
# -- -- -- -- -- 

{ ... }: {
  security.pam = {
    services = {
      swaylock = {};  # ! require for swaylock
      hyprlock = {};  # ! require for hyprlock
    };
  };
}
