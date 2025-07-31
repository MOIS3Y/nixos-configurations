# █▀▀ █ ▀█▀ ▀
# █▄█ █ ░█░ ▄
# -- -- -- --

{ lib, ... }: {
  programs.git = {
    enable = lib.mkDefault true;
    userName = "MOIS3Y";
    userEmail = "stepan@zhukovsky.me";
    extraConfig = {
      core.editor = "nvim";
    };
  };
}
