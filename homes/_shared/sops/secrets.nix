# █▀ █▀▀ █▀▀ █▀█ █▀▀ ▀█▀ █▀ ▀
# ▄█ ██▄ █▄▄ █▀▄ ██▄ ░█░ ▄█ ▄
# -- -- -- -- -- -- -- -- --

{ config, ... }: {
  stepan = {
    # ssh-keys:
    "ssh/private-keys/self/allsave" = {
      path = "${config.home.homeDirectory}/.ssh/self/allsave";
    };
    "ssh/private-keys/self/gitea" = {
      path = "${config.home.homeDirectory}/.ssh/self/gitea";
    };
    "ssh/private-keys/self/gliese" = {
      path = "${config.home.homeDirectory}/.ssh/self/gliese";
    };
    "ssh/private-keys/self/solar" = {
      path = "${config.home.homeDirectory}/.ssh/self/solar";
    };
    "ssh/private-keys/self/pixel" = {
      path = "${config.home.homeDirectory}/.ssh/self/pixel";
    };
    "ssh/private-keys/ispsystem/go" = {
      path = "${config.home.homeDirectory}/.ssh/ispsystem/go";
    };
    "ssh/private-keys/ispsystem/gitea" = {
      path = "${config.home.homeDirectory}/.ssh/ispsystem/gitea";
    };
    "ssh/private-keys/misc/github" = {
      path = "${config.home.homeDirectory}/.ssh/ispsystem/github";
    };

    "ssh/public-keys/self/allsave" = {
      path = "${config.home.homeDirectory}/.ssh/self/allsave.pub";
    };
    "ssh/public-keys/self/gitea" = {
      path = "${config.home.homeDirectory}/.ssh/self/gitea.pub";
    };
    "ssh/public-keys/self/gliese" = {
      path = "${config.home.homeDirectory}/.ssh/self/gliese.pub";
    };
    "ssh/public-keys/self/solar" = {
      path = "${config.home.homeDirectory}/.ssh/self/solar.pub";
    };
    "ssh/public-keys/self/pixel" = {
      path = "${config.home.homeDirectory}/.ssh/self/pixel.pub";
    };
    "ssh/public-keys/ispsystem/go" = {
      path = "${config.home.homeDirectory}/.ssh/ispsystem/go.pub";
    };
    "ssh/public-keys/ispsystem/gitea" = {
      path = "${config.home.homeDirectory}/.ssh/ispsystem/gitea.pub";
    };
    "ssh/public-keys/misc/github" = {
      path = "${config.home.homeDirectory}/.ssh/misc/github.pub";
    };
    # google calendar fetchers:
    "google-calendar/fetch-id" = {};
    "google-calendar/fetch-secret" = {};
    # gemini-cli
    "gemini-cli/gcp-id" = {};
    # ... add more secrets here:
  };
  # ... add more users with secrets here:
}
