# █▀ █▀ █░█ ▀
# ▄█ ▄█ █▀█ ▄
# -- -- -- --

{ config, pkgs, ... }:
  let
    go-cert = "${config.home.homeDirectory}/.ssh/ispsystem/go-cert.pub";
    cert-ssh = with pkgs; writeShellScriptBin "cert-ssh" ''
      export VAULT_ADDR="https://vault.ispsystem.net:8200"

      _SECRET_KEY=${config.sops.secrets."private-keys/ispsystem/go".path}
      _PUBLIC_KEY=@${config.sops.secrets."public-keys/ispsystem/go".path}
      _CRT_FILE=${go-cert}

      get_vault_crt() {
        local public_key=$1
        local crt_file=$2
        ${pkgs.vault}/bin/vault login -method=oidc
        if [ ! -f $crt_file ]; then
          touch $crt_file
        fi
        ${pkgs.vault}/bin/vault write -field=signed_key ssh/sign/support \
        public_key=$public_key valid_principals=root > $crt_file
      }

      set_ssh_agent() {
        local secret_key=$1
        ${pkgs.openssh}/bin/ssh-add -D
        ${pkgs.openssh}/bin/ssh-add $secret_key
      }

      main() {
        get_vault_crt $_PUBLIC_KEY $_CRT_FILE
        set_ssh_agent $_SECRET_KEY
      }
      # RUN IT:
      main
    '';
  in {
  home.file."${config.home.homeDirectory}/.local/bin/cert-ssh" = {
    source = "${cert-ssh}/bin/cert-ssh";
  };

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
        certificateFile = "${go-cert}";
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
