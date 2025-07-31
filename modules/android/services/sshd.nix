# █▀ █▀ █░█ █▀▄ ▀
# ▄█ ▄█ █▀█ █▄▀ ▄
# -- -- -- -- -- 

{ config, pkgs, lib, ... }: let
  cfg = config.services.sshd;
  inherit (lib)
    mkEnableOption
    mkOption
    mkIf
    literalExpression
    types;

  # utility functions
  concatLines = list: builtins.concatStringsSep "\n" list;
  prefixLines = mapper: list: concatLines (map mapper list);

  # could be put in the config
  configPath = "ssh/sshd_config";
  keysFolder = "/etc/ssh";
  authorizedKeysFolder = "/etc/ssh/authorized_keys.d";
  supportedKeysTypes = [
    "rsa"
    "ed25519"
  ];
  pathOfKeyOf = type: "${keysFolder}/ssh_host_${type}_key";
  generateKeyOf = type: ''
    $DRY_RUN_CMD ${pkgs.openssh}/bin/ssh-keygen \
      -t "${type}" \
      -f "${pathOfKeyOf type}" \
      -N ""
  '';
  generateKeyWhenNeededOf = type: ''
    if [ ! -f ${pathOfKeyOf type} ]; then
      $DRY_RUN_CMD mkdir --parents ${keysFolder}
      $VERBOSE_ECHO "Generating host keys..."
      ${generateKeyOf type}
    fi
  '';
  appendAuthorizedKeys = authorizedKeys: ''
    $DRY_RUN_CMD echo ${concatLines authorizedKeys} >${authorizedKeysFolder}/${config.user.userName}
  '';

  # bin tools:
  sshd-init = pkgs.writeScriptBin "sshd-init" ''
    #!${pkgs.runtimeShell}
    ${prefixLines generateKeyWhenNeededOf supportedKeysTypes}
    if [ ! -d "${authorizedKeysFolder}" ]; then
      $DRY_RUN_CMD mkdir --parents "${authorizedKeysFolder}"
    fi
    ${appendAuthorizedKeys cfg.authorizedKeys}
  '';
  sshd-start = pkgs.writeScriptBin "sshd-start" ''
    #!${pkgs.runtimeShell}
    echo "Starting sshd on port(s) ${lib.concatMapStrings toString cfg.ports}"
    ${pkgs.openssh}/bin/sshd -f "/etc/${configPath}"
  '';
  sshd-stop = pkgs.writeScriptBin "sshd-stop" ''
    #!${pkgs.runtimeShell}
    if ! ${pkgs.killall}/bin/killall sshd >> /dev/null 2>&1; then
        echo "sshd service has already stopped"
    else
        echo "sshd service stopped"
    fi
  '';
in {
  options.services.sshd = {
    enable = mkEnableOption ''
      Whether to enable the OpenSSH secure shell daemon, which
      allows secure remote logins.
    '';
    ports = mkOption {
      type = types.listOf types.port;
      default = [ 8022 ];
      description = "Specifies on which ports the SSH daemon listens.";
      example = literalExpression ''
        services.sshd.ports = [
          2222
          8022
        ];
      '';
    };
    authorizedKeys = mkOption {
      type = types.listOf types.str;
      default = [];
      description = ''
        A list of verbatim OpenSSH public keys that should be added
        to the user's authorized keys.
      '';
      example = literalExpression ''
        services.sshd.authorizedKeys = [
          "key1"
          "key2"
        ];
      '';
    };
  };
  config = mkIf cfg.enable {
    environment.etc = {
      "${configPath}".text = ''
        ${prefixLines (port: "Port ${toString port}") cfg.ports}
        AuthorizedKeysFile ${authorizedKeysFolder}/%u
        LogLevel VERBOSE
      '';
    };
    environment.packages = [
      sshd-start
      sshd-stop
      pkgs.openssh
    ];
    build.activation.sshd = ''
      $DRY_RUN_CMD ${sshd-init}/bin/sshd-init
    '';
  };
}
