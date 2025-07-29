# █░█ █▀ █▀▀ █▀█ █▀ ▀
# █▄█ ▄█ ██▄ █▀▄ ▄█ ▄
# -- -- -- -- -- -- -

{ config, pkgs, lib, ... }: {
  users = {
    users = lib.attrsets.getAttrs config.host.users (
      import ./users.nix { inherit config pkgs; }
    );
  };
}
