# █▀ █▀ █░█ ▀
# ▄█ ▄█ █▀█ ▄
# -- -- -- --
# Configures the SSH client, including user-specific matchBlocks.

{
  config,
  lib,
  ...
}:
let
  cfg = config.programs.ssh;
  inherit (lib) mkOption types attrsets;

  matchers = {
    empty = { };
    nix-on-droid = {
      # TODO: create custom sops managment (can't install nix-sops on android)
      # isp:
      "services.isptech.ru" = {
        User = "admserv";
        IdentityFile = "${config.home.homeDirectory}/.ssh/ispsystem/go";
        Port = 2222;
        HostName = "172.31.52.25";
      };
      # self:
      "allsave" = {
        User = "admserv";
        IdentityFile = "${config.home.homeDirectory}/.ssh/self/allsave";
        Port = 22;
        HostName = "192.168.1.100";
      };
      "gliese" = {
        User = "admvps";
        IdentityFile = "${config.home.homeDirectory}/.ssh/self/gliese";
        Port = 22;
        HostName = "gliese.zhukovsky.me";
      };
      "solar" = {
        User = "admvps";
        IdentityFile = "${config.home.homeDirectory}/.ssh/self/solar";
        Port = 2222;
        HostName = "solar.zhukovsky.me";
      };
    };
    stepan = {
      # isp:
      "isp" = {
        User = "s.zhukovskii";
        IdentityFile = config.sops.secrets."ssh/private-keys/ispsystem/go".path;
        CertificateFile = "${config.home.homeDirectory}/.ssh/ispsystem/go-cert.pub";
        Port = 22;
        HostName = "ssh.ispsystem.net";
      };
      "isp-de" = {
        User = "s.zhukovskii";
        IdentityFile = config.sops.secrets."ssh/private-keys/ispsystem/go".path;
        CertificateFile = "${config.home.homeDirectory}/.ssh/ispsystem/go-cert.pub";
        Port = 22;
        HostName = "ssh-de.ispsystem.net";
      };
      "gitlab-dev.ispsystem.net" = {
        IdentityFile = config.sops.secrets."ssh/private-keys/ispsystem/go".path;
        IdentitiesOnly = "yes";
        Port = 22;
        HostName = "gitlab-dev.ispsystem.net";
      };
      "services.isptech.ru" = {
        User = "admserv";
        IdentityFile = config.sops.secrets."ssh/private-keys/ispsystem/go".path;
        Port = 2222;
        HostName = "172.31.52.25";
      };
      "git.isptech.ru" = {
        IdentityFile = config.sops.secrets."ssh/private-keys/ispsystem/gitea".path;
        IdentitiesOnly = "yes";
        Port = 1488;
        HostName = "git.isptech.ru";
      };
      # misc:
      "github.com" = {
        IdentityFile = config.sops.secrets."ssh/private-keys/misc/github".path;
        IdentitiesOnly = "yes";
        Port = 22;
        HostName = "github.com";
      };
      # self:
      "allsave" = {
        User = "admserv";
        IdentityFile = config.sops.secrets."ssh/private-keys/self/allsave".path;
        Port = 22;
        HostName = "192.168.1.100";
      };
      "git.zhukovsky.me" = {
        User = "git";
        IdentityFile = config.sops.secrets."ssh/private-keys/self/gitea".path;
        IdentitiesOnly = "yes";
        Port = 22;
        HostName = "git.zhukovsky.me";
      };
      "gliese" = {
        User = "admvps";
        IdentityFile = config.sops.secrets."ssh/private-keys/self/gliese".path;
        Port = 22;
        HostName = "gliese.zhukovsky.me";
      };
      "solar" = {
        User = "admvps";
        IdentityFile = config.sops.secrets."ssh/private-keys/self/solar".path;
        Port = 2222;
        HostName = "solar.zhukovsky.me";
      };
      "pixel" = {
        User = "nix-on-droid";
        IdentityFile = config.sops.secrets."ssh/private-keys/self/pixel".path;
        Port = 8022;
        HostName = "pixel.zhukovsky.me";
      };
      # add more stepan matchers here ...
    };
    # add more users with matchers here ...
  };
in
{
  options.programs.ssh = {
    userMatchBlocks = mkOption {
      type = types.enum [
        "stepan"
        "admserv"
        "nix-on-droid"
        "empty" # ? if user doesn't use matchBlocks
      ];
      default = "empty";
      description = "Pre-configured user-specific matchBlocks";
    };
  };
  config = {
    programs.ssh = {
      enable = true;
      extraOptionOverrides = {
        AddKeysToAgent = "yes";
      };
      enableDefaultConfig = false;
      # empty is a default value {} to return if the path does not exist in attrset;
      settings = attrsets.attrByPath [ cfg.userMatchBlocks ] "empty" matchers;
    };
  };
}
