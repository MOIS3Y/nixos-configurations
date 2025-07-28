# █▀▀ █▀█ █▀▀ █▀▀ ▀█▀ █▀▄ ▀
# █▄█ █▀▄ ██▄ ██▄ ░█░ █▄▀ ▄
# -- -- -- -- -- -- -- -- -

{ config, pkgs, lib, ... }: lib.mkIf config.desktop.displayManager.greetd.enable {
  assertions = [
    {
      assertion = config.services.displayManager.enable;
      message = ''
        sessions list depends of config.services.displayManager.sessionData
        To fix this error set:
        config.services.displayManager.enable = true;
      '';
    }
    { 
      assertion = !config.services.displayManager.sddm.enable;
      message = ''
        greetd conflicts with sddm. Please, choose on of them.
        To fix this error set:
        config.services.displayManager.sddm.enable = false;
      '';
    }
  ];
  services.greetd = {
    enable = true;
    vt = 7;
    settings = {
      default_session = {
        user = "greeter";
        command = ''
          ${lib.getExe pkgs.greetd.tuigreet} \
            --time \
            --sessions ${config.services.displayManager.sessionData.desktops}/share/wayland-sessions \
            --remember-session \
            --remember \
            --user-menu \
            --user-menu-min-uid 1000 \
            --asterisks \
            --greeting "Welcome to NixOS ${pkgs.hostPlatform.parsed.cpu.arch} system on ${pkgs.linux.version} Linux kernel" \
            --theme "border=magenta;text=blue;prompt=green;time=red;action=blue;button=yellow;container=black;input=red"
        '';
      };
    };
  };
  # ? yoinked from:
  # https://github.com/sjcobb2022/nixos-config/blob/main/hosts/common/optional/greetd.nix
  # https://codeberg.org/kye/nixos/src/branch/master/home/greetd/default.nix
  systemd.services.greetd.serviceConfig = {
    Type = "idle";
    StandardInput = "tty";
    StandardOutput = "tty";
    # Without this errors will spam on screen
    StandardError = "journal";
    # Without these boot logs will spam on screen
    TTYReset = true;
    TTYVHangup = true;
    TTYVTDisallocate = true;
  };
}