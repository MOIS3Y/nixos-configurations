# █▀▀ █ ▀█▀ ▀
# █▄█ █ ░█░ ▄
# -- -- -- --

{ lib, ... }: {
  programs.git = {
    enable = lib.mkDefault true;
    userName = "MOIS3Y";
    userEmail = "stepan@zhukovsky.me";
    signing = {
      format = "openpgp";
      key = "F40E8485FB87A653";
      signByDefault = true;
    };
    extraConfig = {
      core.editor = "nvim";
    };
  };
}
