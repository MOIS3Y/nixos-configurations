# █░█ █▀ █▀▀ █▀█ █▀ ▀
# █▄█ ▄█ ██▄ █▀▄ ▄█ ▄
# -- -- -- -- -- -- -

{ config, pkgs, lib, ... }: {
  stepan = {
    isNormalUser = true;
    description = "Stepan Zhukovsky";
    extraGroups = [ 
      "networkmanager"
      "wireshark"
      "wheel"
      "libvirtd"
      "input"
      "i2c"
    ];
    shell = pkgs.zsh;
    packages = [
      # add default user pkgs here or in HM configuration ... 
    ] ++ lib.optionals (config.host.virtualisation.libvirtd.enable) [
      pkgs.virt-manager
    ] ++ lib.optionals (config.desktop.games.enable or null != null)
      config.desktop.games.extraPackages;
  };
  admserv = {
    isNormalUser = true;
    description = "Stepan Zhukovsky";
    extraGroups = [ "wheel" ];
    shell = pkgs.zsh;
    packages = [];
  };
  # add more users here ...
}
