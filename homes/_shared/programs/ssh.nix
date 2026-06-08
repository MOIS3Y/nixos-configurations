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
    stepan = {
      # isp:
      "isp" = {
        User = "s.zhukovskii";
        IdentityFile = config.sops.secrets."ssh/private-keys/ispsystem/go".path;
        CertificateFile = "${config.home.homeDirectory}/.ssh/ispsystem/go-cert.pub";
        IdentitiesOnly = "yes";
        Port = 22;
        HostName = "ssh.ispsystem.net";
      };
      "isp-de" = {
        User = "s.zhukovskii";
        IdentityFile = config.sops.secrets."ssh/private-keys/ispsystem/go".path;
        CertificateFile = "${config.home.homeDirectory}/.ssh/ispsystem/go-cert.pub";
        IdentitiesOnly = "yes";
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
        IdentitiesOnly = "yes";
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
      "router" = {
        User = "root";
        IdentityFile = "${config.home.homeDirectory}/.ssh/self/router";
        IdentitiesOnly = "yes";
        Port = 22;
        HostName = "192.168.1.1";
      };
      "allsave" = {
        User = "admserv";
        IdentityFile = config.sops.secrets."ssh/private-keys/self/allsave".path;
        IdentitiesOnly = "yes";
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
        IdentitiesOnly = "yes";
        Port = 22;
        HostName = "gliese.zhukovsky.me";
      };
      "solar" = {
        User = "admvps";
        IdentityFile = config.sops.secrets."ssh/private-keys/self/solar".path;
        IdentitiesOnly = "yes";
        Port = 22;
        HostName = "solar.zhukovsky.me";
      };
      "polaris" = {
        User = "admvps";
        IdentityFile = "${config.home.homeDirectory}/.ssh/self/polaris";
        IdentitiesOnly = "yes";
        Port = 22;
        HostName = "polaris.zhukovsky.me";
      };
      "pixel" = {
        User = "nix-on-droid";
        IdentityFile = config.sops.secrets."ssh/private-keys/self/pixel".path;
        IdentitiesOnly = "yes";
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
