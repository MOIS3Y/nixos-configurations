# █▀█ █▀█ █▀▀ █▄░█ █▀ █▀ █░█ ▀
# █▄█ █▀▀ ██▄ █░▀█ ▄█ ▄█ █▀█ ▄
# -- -- -- -- -- -- -- -- -- -

{ ...}: {
  services.openssh = {
    enable = true;
    startWhenNeeded = true;
    allowSFTP = true;
    settings = {
      PermitRootLogin = "yes";
      PasswordAuthentication = true;
      LogLevel = "INFO";
    };
  };
}
