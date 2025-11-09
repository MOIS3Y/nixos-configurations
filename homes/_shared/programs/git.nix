# █▀▀ █ ▀█▀ ▀
# █▄█ █ ░█░ ▄
# -- -- -- --

{ lib, ... }: {
  programs.git = {
    enable = lib.mkDefault true;
    signing = {
      format = "openpgp";
      key = "F40E8485FB87A653";
      signByDefault = true;
    };
    settings = {
      core.editor = "nvim";
      user = {
        name = "MOIS3Y";
        email = "stepan@zhukovsky.me";
      };
    };
  };
}
