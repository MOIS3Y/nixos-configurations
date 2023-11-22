# █░█ █▀ █▀▀ █▀█ █▀ ▀
# █▄█ ▄█ ██▄ █▀▄ ▄█ ▄
# -- -- -- -- -- -- -

{ config, pkgs, ... }: {
  # Define a user account. Don't forget to set a password with ‘passwd’.
  users.users = { 
    stepan = {
      isNormalUser = true;
      description = "Stepan Zhukovsky";
      extraGroups = [ "networkmanager" "wheel" "libvirtd" "input" ];
      shell = pkgs.zsh;
      packages = with pkgs; [
        virt-manager
      ];
    };
    # ... add more users here
  };
}
