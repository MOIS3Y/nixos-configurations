# █▀▀ █ ▀█▀ ▀
# █▄█ █ ░█░ ▄
# -- -- -- --

{ ... }: {
  programs.git = {
    enable = true;
    userName = "MOIS3Y";
    userEmail = "stepan@zhukovsky.me";
    extraConfig = {
      core.editor = "nvim";
    };
  };
}