# █░█ █▀ █▀▀ █▀█ █▀ ▀
# █▄█ ▄█ ██▄ █▀▄ ▄█ ▄
# -- -- -- -- -- -- -

{ pkgs, ... }: {
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
  };
  # add more users here ...
}
