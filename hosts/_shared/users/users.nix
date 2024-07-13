# █░█ █▀ █▀▀ █▀█ █▀ ▀
# █▄█ ▄█ ██▄ █▀▄ ▄█ ▄
# -- -- -- -- -- -- -

{ config, pkgs, ... }: {
  stepan = {
    isNormalUser = true;
    description = "Stepan Zhukovsky";
    extraGroups = [ "networkmanager" "wheel" "libvirtd" "input" "i2c" ];
    hashedPasswordFile = config.sops.secrets.stepan-password.path;
    shell = pkgs.zsh;
    packages = with pkgs; [] ++ ( if config.host.virtualisation.libvirtd.enable
      then [ virt-manager ]
      else []
    );
  };
  admserv = {
    isNormalUser = true;
    description = "Stepan Zhukovsky";
    extraGroups = [ "wheel" ];
    hashedPasswordFile = config.sops.secrets.admserv-password.path;
    shell = pkgs.zsh;
    packages = with pkgs; [];
  };
  # add more users here ...
}
