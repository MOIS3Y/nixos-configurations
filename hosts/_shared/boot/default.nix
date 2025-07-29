# █▄▄ █▀█ █▀█ ▀█▀ ▀
# █▄█ █▄█ █▄█ ░█░ ▄
# -- -- -- -- -- --

{ ... }: {
  imports = [
    ./loader.nix
    ./plymouth.nix
  ];
  boot = {
    # ? silent boot (see initrd.verbose description): 
    initrd.verbose = false;
    consoleLogLevel = 0;
    kernelParams = [ "quiet" "udev.log_level=3" ];
    # ? -- -- -- --
  };
}
