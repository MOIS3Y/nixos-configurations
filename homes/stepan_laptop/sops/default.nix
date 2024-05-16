# █▀ █▀█ █▀█ █▀ ▀
# ▄█ █▄█ █▀▀ ▄█ ▄
# -- -- -- -- -- 

{ config, pkgs, ... }: {
  imports = [
    ../../_shared/sops
  ];
  defaultUserSopsFile = ../../../secrets/homes/stepan/secrets.yaml;
  sops = {
    secrets = {
      # ssh-keys:
      "private-keys/self/allsave" = { 
        path = "${config.home.homeDirectory}/.ssh/self/allsave"; 
      };
      "private-keys/self/gitea" = { 
        path = "${config.home.homeDirectory}/.ssh/self/gitea"; 
      };
      "private-keys/self/gliese" = { 
        path = "${config.home.homeDirectory}/.ssh/self/gliese"; 
      };
      "private-keys/self/solar" = { 
        path = "${config.home.homeDirectory}/.ssh/self/solar"; 
      };
      "private-keys/ispsystem/go" = { 
        path = "${config.home.homeDirectory}/.ssh/ispsystem/go"; 
      };
      "private-keys/ispsystem/gitea" = { 
        path = "${config.home.homeDirectory}/.ssh/ispsystem/gitea"; 
      };
      "private-keys/misc/github" = { 
        path = "${config.home.homeDirectory}/.ssh/ispsystem/github"; 
      };

      "public-keys/self/allsave" = { 
        path = "${config.home.homeDirectory}/.ssh/self/allsave.pub"; 
      };
      "public-keys/self/gitea" = { 
        path = "${config.home.homeDirectory}/.ssh/self/gitea.pub"; 
      };
      "public-keys/self/gliese" = { 
        path = "${config.home.homeDirectory}/.ssh/self/gliese.pub"; 
      };
      "public-keys/self/solar" = { 
        path = "${config.home.homeDirectory}/.ssh/self/solar.pub"; 
      };
      "public-keys/ispsystem/go" = { 
        path = "${config.home.homeDirectory}/.ssh/ispsystem/go.pub"; 
      };
      "public-keys/ispsystem/gitea" = { 
        path = "${config.home.homeDirectory}/.ssh/ispsystem/gitea.pub"; 
      };
      "public-keys/misc/github" = { 
        path = "${config.home.homeDirectory}/.ssh/misc/github.pub"; 
      };
      # google calendar fetchers:
      "google-calendar/fetch-id" = {};
      "google-calendar/fetch-secret" = {};
      # ... add more secrets here:
    };
  };
}
