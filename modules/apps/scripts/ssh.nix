# █▀ █▀ █░█ ▀
# ▄█ ▄█ █▀█ ▄
# -- -- -- --

{ config, pkgs, utils, ... }: with utils; {
  cert-ssh = pkgs.writeShellScript "ssh-cert-ssh.sh" ''
    export VAULT_ADDR="https://vault.ispsystem.net:8200"

    _SECRET_KEY=${config.sops.secrets."private-keys/ispsystem/go".path}
    _PUBLIC_KEY=@${config.sops.secrets."public-keys/ispsystem/go".path}
    _CRT_FILE="${config.home.homeDirectory}/.ssh/ispsystem/go-cert.pub"

    get_vault_crt() {
      local public_key=$1
      local crt_file=$2
      ${vault} login -method=oidc
      if [ ! -f $crt_file ]; then
        touch $crt_file
      fi
      ${vault} write -field=signed_key ssh/sign/support \
      public_key=$public_key valid_principals=root > $crt_file
    }

    set_ssh_agent() {
      local secret_key=$1
      ${ssh-add} -D
      ${ssh-add} $secret_key
    }

    main() {
      get_vault_crt $_PUBLIC_KEY $_CRT_FILE
      set_ssh_agent $_SECRET_KEY
    }
    # RUN IT:
    main
  '';
}
