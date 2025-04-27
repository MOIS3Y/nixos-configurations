# █▀█ █▀█ █▀█ █▀▀ █▀█ ▄▀█ █▀▄▀█ █▀ ▀
# █▀▀ █▀▄ █▄█ █▄█ █▀▄ █▀█ █░▀░█ ▄█ ▄
# -- -- -- -- -- -- -- -- -- -- -- -

{ pkgs, ...}: {
  programs = {
    wireshark = {
      enable = true;
      package = pkgs.wireshark;  # ? gui version
    };
    # add more common desktop programs here ...
  };
}