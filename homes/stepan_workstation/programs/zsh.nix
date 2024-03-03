# ▀█ █▀ █░█ ▀
# █▄ ▄█ █▀█ ▄
# -- -- -- --

{ config, pkgs, ... }: {
  programs.zsh = {
    enable = true;
    enableCompletion = true;
    enableAutosuggestions = true;
    syntaxHighlighting.enable = true;
    dotDir = ".config/zsh";
    history = {
      save = 10000;
      size = 10000;
      path = "${config.xdg.dataHome}/zsh/history";
    };
    sessionVariables = {
      PATH = "/home/${config.home.username}/.local/bin:$PATH";
      EDITOR = "nvim";
      VISUAL = "code";
    };
    shellAliases = {
      docker = "sudo docker";
      docker-compose = "sudo docker-compose";
    };
    oh-my-zsh = {
      enable = true;
      plugins = ["git"];
      extraConfig = ''
        if [[ "$TERM" = "linux" ]]; then
          ZSH_THEME="jonathan"
        else
          ZSH_THEME="gnzh"
        fi
      '';
    };
  };
}
