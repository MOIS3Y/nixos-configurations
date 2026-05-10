{ config, lib, ... }: let
  inherit (lib)
    optionalAttrs;
in {
  systemd.tmpfiles.settings = {
    # add base systemd tmpfiles settings here ...
  }
  // optionalAttrs config.services.greetd.enable {
    "10-mdgreet" = {
      "/var/cache/mdgreet".d = {
        mode = "0755";
        user = "greeter";
        group = "greeter";
      };
      "/var/log/mdgreet".d = {
        mode = "0755";
        user = "greeter";
        group = "greeter";
      };
    };
  };
}
