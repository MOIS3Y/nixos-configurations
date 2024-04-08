# █▀█ █▀▀ █ ▄▄ █▀▀ █▀█ █▄░█ ▀█▀ ▄▀█ █ █▄░█ █▀▀ █▀█ █▀ ▀
# █▄█ █▄▄ █ ░░ █▄▄ █▄█ █░▀█ ░█░ █▀█ █ █░▀█ ██▄ █▀▄ ▄█ ▄
# -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- --

{ config, pkgs, ...}:{
  virtualisation.oci-containers = {
    backend = "docker";
    containers = {
      ipsec-vpn-server = {
        image = "hwdsl2/ipsec-vpn-server";
        hostname = "ipsec-vpn-server";
        autoStart = true;
        ports = [
          "500:500/udp"
          "4500:4500/udp"
        ];
        volumes = [
          "ipsec_vpn_server_data:/etc/ipsec.d"
          "/run/current-system/kernel-modules/lib/modules:/lib/modules:ro"
        ];
        environmentFiles = [
          config.sops.secrets.ipsec-vpn-server-env.path
        ];
        extraOptions = [
          "--privileged"
        ];
      };
    };
  };
}
