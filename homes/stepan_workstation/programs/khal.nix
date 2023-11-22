# █▄▀ █░█ ▄▀█ █░░ ▀
# █░█ █▀█ █▀█ █▄▄ ▄
# -- -- -- -- -- --

# ! still doesn't work 
# ! https://github.com/nix-community/home-manager/issues/4675
{ config, pkgs, ... }: {
  accounts.calendar.accounts = {
    work = {};
  };
  programs.khal = {
    enable = true;
    settings = {
      default = {
        default_calendar = "work";
        highlight_event_days = true;
      };
      highlight_days = {
        color = "#ed8796";
      };
    };
  };
}
