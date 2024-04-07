# █▀█ █▀█ █▀▀ █▄░█ █▀ █▀ █░█ ▀
# █▄█ █▀▀ ██▄ █░▀█ ▄█ ▄█ █▀█ ▄
# -- -- -- -- -- -- -- -- -- -

{config, pkgs, ... }: {
  services.openssh = {
    enable = true;
    startWhenNeeded = true;
    allowSFTP = true;
    PermitRootLogin = "no";
    PasswordAuthentication = false;
    listenAddresses = [
      {
        addr = "0.0.0.0";
        port = 22;  # default
      }
    ];
    LogLevel = "INFO";
    banner = ''
      █▀▀ █░░ █ █▀▀ █▀ █▀▀
      █▄█ █▄▄ █ ██▄ ▄█ ██▄
    '';
  };
}
