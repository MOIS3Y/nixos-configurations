# █░█ █▀ █▀▀ █▀█ █▀ ▀
# █▄█ ▄█ ██▄ █▀▄ ▄█ ▄
# -- -- -- -- -- -- -

{ config, pkgs, ... }: {
  # Define a user account. Don't forget to set a password with ‘passwd’.
  users.users = { 
    admserv = {
      isNormalUser = true;
      description = "Stepan Zhukovsky";
      extraGroups = [ "wheel" ];
      shell = pkgs.zsh;
      packages = with pkgs; [];
    };
    # ... add more users here
  };
}
