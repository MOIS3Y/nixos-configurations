# █▀▄▀█ ▄▀█ ▀█▀ █▀▀ █░█ █▀▀ █▀█ █▀ ▀
# █░▀░█ █▀█ ░█░ █▄▄ █▀█ ██▄ █▀▄ ▄█ ▄
# -- -- -- -- -- -- -- -- -- -- -- -

{ config, ... }: {
  empty = {};
  nix-on-droid = {
    # TODO: create custom sops managment (can't install nix-sops on android)
    # isp:
    "services.isptech.ru" = {
      user = "admserv";
      identityFile = "${config.home.homeDirectory}/.ssh/ispsystem/go";
      port = 2222;
      hostname = "172.31.52.25";
    };    
    # self:
    "allsave" = {
      user = "admserv";
      identityFile = "${config.home.homeDirectory}/.ssh/self/allsave";
      port = 22;
      hostname = "192.168.1.100";
    };
    "gliese" = {
      user = "admvps";
      identityFile = "${config.home.homeDirectory}/.ssh/self/gliese";
      port = 22;
      hostname = "gliese.zhukovsky.me";
    };
    "solar" = {
      user = "admvps";
      identityFile = "${config.home.homeDirectory}/.ssh/self/solar";
      port = 2222;
      hostname = "solar.zhukovsky.me";
    };
  };
  stepan = {
    # isp:
    "isp" = {
      user = "s.zhukovskii";
      identityFile = config.sops.secrets."private-keys/ispsystem/go".path;
      certificateFile = "${config.home.homeDirectory}/.ssh/ispsystem/go-cert.pub";
      port = 22;
      hostname = "ssh.ispsystem.net";
    };
    "isp-de" = {
      user = "s.zhukovskii";
      identityFile = config.sops.secrets."private-keys/ispsystem/go".path;
      certificateFile = "${config.home.homeDirectory}/.ssh/ispsystem/go-cert.pub";
      port = 22;
      hostname = "ssh-de.ispsystem.net";
    };
    "gitlab-dev.ispsystem.net" = {
      identityFile = config.sops.secrets."private-keys/ispsystem/go".path;
      identitiesOnly = true;
      port = 22;
      hostname = "gitlab-dev.ispsystem.net";
    };
    "services.isptech.ru" = {
      user = "admserv";
      identityFile = config.sops.secrets."private-keys/ispsystem/go".path;
      port = 2222;
      hostname = "172.31.52.25";
    };
    "git.isptech.ru" = {
      identityFile = config.sops.secrets."private-keys/ispsystem/gitea".path;
      identitiesOnly = true;
      port = 1488;
      hostname = "git.isptech.ru";
    };
    # misc:
    "github.com" = {
      identityFile = config.sops.secrets."private-keys/misc/github".path;
      identitiesOnly = true;
      port = 22;
      hostname = "github.com";
    };
    # self:
    "allsave" = {
      user = "admserv";
      identityFile = config.sops.secrets."private-keys/self/allsave".path;
      port = 22;
      hostname = "192.168.1.100";
    };
    "git.zhukovsky.me" = {
      user = "git";
      identityFile = config.sops.secrets."private-keys/self/gitea".path;
      identitiesOnly = true;
      port = 22;
      hostname = "git.zhukovsky.me";
    };
    "gliese" = {
      user = "admvps";
      identityFile = config.sops.secrets."private-keys/self/gliese".path;
      port = 22;
      hostname = "gliese.zhukovsky.me";
    };
    "solar" = {
      user = "admvps";
      identityFile = config.sops.secrets."private-keys/self/solar".path;
      port = 2222;
      hostname = "solar.zhukovsky.me";
    };
    "pixel" = {
      user = "nix-on-droid";
      identityFile = config.sops.secrets."private-keys/self/pixel".path;
      port = 8022;
      hostname = "pixel.zhukovsky.me";
    };
    # add more stepan matchers here ... 
  };
  # add more users with matchers here ...
}
