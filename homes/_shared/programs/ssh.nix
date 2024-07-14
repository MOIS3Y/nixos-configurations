# █▀ █▀ █░█ ▀
# ▄█ ▄█ █▀█ ▄
# -- -- -- --

{ config, pkgs, ... }: {
  programs.ssh = {
    enable = true;
    extraOptionOverrides = {
      AddKeysToAgent = "yes";
    };
    matchBlocks = {
      # isp:
      "isp" = {
        user = "s.zhukovskii";
        identityFile = config.sops.secrets."private-keys/ispsystem/go".path;
        certificateFile = "${config.home.homeDirectory}/.ssh/ispsystem/go-cert.pub";
        port = 22;
        hostname = "ssh.ispsystem.net";
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
        hostname = "185.60.134.99";
      };
      "git.isptech.ru" = {
        identityFile = config.sops.secrets."private-keys/ispsystem/gitea".path;
        identitiesOnly = true;
        port = 22;
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
        user = "admserv";
        identityFile = config.sops.secrets."private-keys/self/gliese".path;
        port = 22;
        hostname = "gliese.zhukovsky.me";
      };
      "solar" = {
        user = "admserv";
        identityFile = config.sops.secrets."private-keys/self/solar".path;
        port = 2222;
        hostname = "solar.zhukovsky.me";
      };
      # ... add more matchers here:
    };
  };
}
