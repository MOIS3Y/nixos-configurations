# █▄▄ █▀█ ▀█▀
# █▄█ █▀█ ░█░
# -- -- -- --
# Configuration for bat, a cat clone with syntax highlighting and Git integration.

{ pkgs, ... }:
{
  programs.bat = {
    enable = true;

    config = {
      # Inherit colors from the terminal (configured via Matugen)
      theme = "base16";

      # Show line numbers, Git modifications, and file header
      style = "numbers,changes,header";

      # Do not wrap long lines
      wrap = "never";
    };

    extraPackages = with pkgs.bat-extras; [
      batdiff
      batgrep
      batman
    ];
  };
}
