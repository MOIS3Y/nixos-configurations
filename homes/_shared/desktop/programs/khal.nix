# █▄▀ █░█ ▄▀█ █░░ ▀
# █░█ █▀█ █▀█ █▄▄ ▄
# -- -- -- -- -- --

# ! I don't use it now because it lacks functionality.
# ! I don’t import the module; it needs refactoring and splitting.
# ! The configuration is working, its use in its current form will affect other users

# ! Current calendar gnome-calendar

{ config, pkgs, ... }: let
  googleCalendarFetchId = pkgs.writeShellScript "khal-gcfid.sh" ''
    ${cat} ${config.sops.secrets."google-calendar/fetch-id".path}
  '';
  googleCalendarFetchSecret = pkgs.writeShellScript "khal-gcfs.sh" ''
    ${cat} ${config.sops.secrets."google-calendar/fetch-secret".path}
  '';
in {
  accounts.calendar = {
    basePath = "${config.xdg.dataHome}/calendars";
    accounts = {
      stepan = {
        primary = true;
        khal = {
          enable = true;
          color = "light green";
          glob = "*";
          priority = 10;
          readOnly = false;
          type = "discover";
        };
        local = {
          type = "filesystem";
          fileExt = ".ics";
        };
        remote = {
          type = "google_calendar";
        };
        vdirsyncer = {
          enable = true;
          tokenFile = "${config.xdg.dataHome}/calendars/google_token_file";
          collections = [ "from a" "from b" ];
          conflictResolution = "remote wins";
          clientIdCommand = [ "${googleCalendarFetchId}" ];
          clientSecretCommand = [ "${googleCalendarFetchSecret}" ];
        };
        primaryCollection = "s.zhukovskii@ispsystem.com"; # workaround
      };
    };
  };

  programs.vdirsyncer = {
    enable = true;
  };

  programs.khal = {
    enable = true;
    locale = {
      # Format strings are for Python strftime, similarly to strftime(3).
      dateformat = "%x";
      datetimeformat = "%c";
      # default_timezone = "Asia/Chita";
      # Monday is 0, Sunday is 6
      firstweekday = 0;
      longdateformat = "%x";
      longdatetimeformat = "%c";
      timeformat = "%X";
      unicode_symbols = true;
    };
    settings = {
      default = {
        default_calendar = "stepan";
        timedelta = "5d";
        highlight_event_days = true;
      };
      view = {
        agenda_event_format =
          "{calendar-color}{cancelled}{start-end-time-style} {title}{repeat-symbol}{reset}";
      };
    };
  };
}
