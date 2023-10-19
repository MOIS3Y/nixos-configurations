# █▄▄ █▀█ █▀█ ▀█▀ ▀
# █▄█ █▄█ █▄█ ░█░ ▄
# -- -- -- -- -- --

{config, pkgs, ...}: {
  
  # boot.kernelParams = [ "quiet" ];
  # boot.consoleLogLevel = 3;
  
  imports = [
    ./loader.nix
    # ./plymouth.nix
  ];
}

