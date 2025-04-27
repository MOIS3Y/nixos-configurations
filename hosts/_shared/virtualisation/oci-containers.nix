# █▀█ █▀▀ █ ▄▄ █▀▀ █▀█ █▄░█ ▀█▀ ▄▀█ █ █▄░█ █▀▀ █▀█ █▀ ▀
# █▄█ █▄▄ █ ░░ █▄▄ █▄█ █░▀█ ░█░ █▀█ █ █░▀█ ██▄ █▀▄ ▄█ ▄
# -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- --

{ ... }: {
  portainer-agent = {
    image = "portainer/agent:2.20.1-alpine";
    hostname = "portainer-agent";
    autoStart = true;
    ports = [
      "9001:9001"
    ];
    volumes = [
      "/var/run/docker.sock:/var/run/docker.sock"
      "/var/lib/docker/volumes:/var/lib/docker/volumes"
    ];
    extraOptions = [
      "--privileged"
    ];
  };
  # add more containers here ...
}
