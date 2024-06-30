# █▀█ █▀█ █▀▀ █▄░█ █▀ █▀ █░█ ▀
# █▄█ █▀▀ ██▄ █░▀█ ▄█ ▄█ █▀█ ▄
# -- -- -- -- -- -- -- -- -- -

{config, pkgs, ... }: {
  services.openssh = {
    enable = true;
    startWhenNeeded = true;
    allowSFTP = true;
    settings = {
      PermitRootLogin = "yes";  # TODO: disable after enable sops
      PasswordAuthentication = true;  # TODO: disable after enable sops
      LogLevel = "INFO";
    };
    listenAddresses = [
      {
        addr = "0.0.0.0";
        port = 22;  # default
      }
    ];
    banner = ''
      ▄▀█ █░░ █░░ █▀ ▄▀█ █░█ █▀▀
      █▀█ █▄▄ █▄▄ ▄█ █▀█ ▀▄▀ ██▄
    '';
  };
}
