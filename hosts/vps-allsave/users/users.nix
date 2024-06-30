# █░█ █▀ █▀▀ █▀█ █▀ ▀
# █▄█ ▄█ ██▄ █▀▄ ▄█ ▄
# -- -- -- -- -- -- -

{ config, pkgs, ... }: {
  users = {
    mutableUsers = false;
    users = { 
      admserv = {
        isNormalUser = true;
        description = "Stepan Zhukovsky";
        extraGroups = [ "wheel" ];
        hashedPasswordFile = config.sops.secrets.admserv-password.path;
        shell = pkgs.zsh;
        packages = with pkgs; [];
        openssh.authorizedKeys.keys = [
          "ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAIIN8ntFxD/6St6f8I9U+W+uqw9tQZQk6nxSBkaYpB5QN home server"
        ];
      };
      # ... add more users here
    };
  };
}
