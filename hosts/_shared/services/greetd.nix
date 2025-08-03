# █▀▀ █▀█ █▀▀ █▀▀ ▀█▀ █▀▄ ▀
# █▄█ █▀▄ ██▄ ██▄ ░█░ █▄▀ ▄
# -- -- -- -- -- -- -- -- -

{ config, pkgs, lib, ... }: {
assertions = [
  {
    assertion = config.services.greetd.enable -> config.services.displayManager.enable;
    message = ''
      [Configuration Error] Display Manager must be enabled for session list functionality.
        greetd depends of session list

      Solution:
      1. Enable the display manager globally:
        Z`services.displayManager.enable = true;`
      
      2. Or enable it via the desktop module:
        `desktop.displayManager.enable = true;`

      Note: This ensures proper session data initialization.
    '';
  }
  { 
    assertion = config.services.greetd.enable -> !config.services.displayManager.sddm.enable;
    message = ''
      [Conflict Detected] SDDM and greetd cannot run simultaneously!

      Resolution:
      • To use greetd, disable SDDM:
        `services.displayManager.sddm.enable = false;`
        or via desktop module:
        `desktop.displayManager.sddm.enable = false;`

      • To use SDDM, disable greetd:
        `services.greetd.enable = false;`
    '';
  }
  { 
    assertion = config.services.greetd.enable -> !config.services.displayManager.gdm.enable;
    message = ''
      [Conflict Detected] GDM and greetd are mutually exclusive!

      Resolution:
      • To use greetd, disable GDM:
        `services.displayManager.gdm.enable = false;`
        or via desktop module:
        `desktop.displayManager.gdm.enable = false;`

      • To use GDM, disable greetd:
        `services.greetd.enable = false;`
    '';
  }
];
  services.greetd = {
    enable = lib.mkDefault config.desktop.displayManager.greetd.enable;
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
}
