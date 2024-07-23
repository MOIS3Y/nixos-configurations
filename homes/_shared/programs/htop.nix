# █░█ ▀█▀ █▀█ █▀█ ▀
# █▀█ ░█░ █▄█ █▀▀ ▄
# -- -- -- -- -- --

{ config, pkgs, lib, ... }: let
  cfg = config.programs.htop;
in {
  options.programs.htop = with lib; {
    os = mkOption {
      type = types.enum [
        "linux"
        "android"
      ];
      default = "linux";
      description = ''
        Operating system type.
        Depending on the type, different fields will be displayed.
        Currently only two types are supported:
        - linux (by default)
        - android for Nix-on-droid devices
      '';
    };
  };
  config = {
    programs.htop = {
      enable = true;
      settings = {
        fields = with config.lib.htop.fields;
          if cfg.os != "android"
            then [
              USER PID PPID STATE PRIORITY NICE PERCENT_CPU PERCENT_MEM TIME COMM
            ]
          else [ PID PPID STATE PRIORITY NICE PERCENT_MEM TIME COMM ];
        header_margin = false;
        hide_threads = true;
        hide_kernel_threads = true;
        hide_userland_threads = true;
        highlight_base_name = true;
        highlight_megabytes = true;
        shadow_other_users = true;
        show_cpu_frequency = true;
        show_program_path = false;
        sort_key = config.lib.htop.fields.PERCENT_MEM;
      } // (with config.lib.htop; leftMeters (
        if cfg.os != "android"
        then [
          (bar "LeftCPUs")
          (bar "Memory")
          (bar "Swap")
        ] else [
          (bar "Memory")
          (bar "Swap")
        ]
      )) // (with config.lib.htop; rightMeters (
        if cfg.os != "android"
        then [
          (bar "RightCPUs")
          (bar "Battery")
          (text "Tasks")
          (text "LoadAverage")
          (text "Uptime")
        ] else [
          (text "Tasks")
        ]
      ));
    };
    # ? workaround: htop overwrites htoprc on the fly, this interferes with activation
    # ? at the moment there is no solution to the problem of backup files on the way
    # ? see: https://github.com/nix-community/home-manager/issues/4199
    home.activation.removeHtoprc = lib.hm.dag.entryBefore ["checkLinkTargets"] ''
      if [ -f "${config.xdg.configHome}/htop/htoprc" ]; then
        rm ${config.xdg.configHome}/htop/htoprc
      fi
    '';
  };
}
