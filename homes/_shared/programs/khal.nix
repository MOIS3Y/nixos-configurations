# █▄▀ █░█ ▄▀█ █░░ ▀
# █░█ █▀█ █▀█ █▄▄ ▄
# -- -- -- -- -- --

{ config, pkgs, ... }: {
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
        vdirsyncer = with config.desktop.scripts.khal; {
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
