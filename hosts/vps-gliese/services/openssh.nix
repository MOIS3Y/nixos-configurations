# █▀█ █▀█ █▀▀ █▄░█ █▀ █▀ █░█ ▀
# █▄█ █▀▀ ██▄ █░▀█ ▄█ ▄█ █▀█ ▄
# -- -- -- -- -- -- -- -- -- -

{config, pkgs, ... }: {
  services.openssh = {
    enable = true;
    startWhenNeeded = true;
    allowSFTP = true;
    settings = {
      PermitRootLogin = "no";
      PasswordAuthentication = false;
      LogLevel = "INFO";
    };
    listenAddresses = [
      {
        addr = "0.0.0.0";
        port = 22;  # default
      }
    ];
    banner = ''
      █▀▀ █░░ █ █▀▀ █▀ █▀▀
      █▄█ █▄▄ █ ██▄ ▄█ ██▄
    '';
  };
}
