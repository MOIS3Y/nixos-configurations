# █░█░█ █▀█ █▀▀ █ ▀
# ▀▄▀▄▀ █▄█ █▀░ █ ▄
# -- -- -- -- - -- 

{ config, ...}: let
  cfg = config.desktop.wayland;
  inherit (config.colorScheme)
    palette;
  in {
  programs.wofi = {
    enable = cfg.enable;
    settings = {
      show = "drun";
      width = 750;
      height = 400;
      always_parse_args = true;
      allow_images = true;
      show_all = false;
      term = "${config.desktop.apps.terminal}";
      hide_scroll = true;
      print_command = true;
      insensitive = true;
      prompt = "";
      columns = 2;
    };
    style = ''
      * {
        font-family: 'Ubuntu', monospace;
        font-size: 14px;
      }

      /* Window */
      window {
        margin: 0px;
        padding: 10px;
        border: 0.10em solid #${palette.base0D};
        border-radius: 0.6em;
        background-color: #${palette.base00};
        animation: slideIn 0.5s ease-in-out both;
      }

      /* Slide In */
      @keyframes slideIn {
        0% {
          opacity: 0;
        }

        100% {
          opacity: 1;
        }
      }

      /* Inner Box */
      #inner-box {
        margin: 5px;
        padding: 10px;
        border: none;
        background-color: #${palette.base00};
        animation: fadeIn 0.5s ease-in-out both;
      }

      /* Fade In */
      @keyframes fadeIn {
        0% {
          opacity: 0;
        }

        100% {
          opacity: 1;
        }
      }

      /* Outer Box */
      #outer-box {
        margin: 5px;
        padding: 10px;
        border: none;
        background-color: #${palette.base00};
      }

      /* Scroll */
      #scroll {
        margin: 0px;
        padding: 10px;
        border: none;
        background-color: #${palette.base00};
      }

      /* Input */
      #input {
        margin: 5px 20px;
        padding: 10px;
        border: none;
        border-radius: 0.6em;
        color: #${palette.base05};
        background-color: #${palette.base01};
        animation: fadeIn 0.5s ease-in-out both;
      }

      #input image {
          border: none;
          color: #${palette.base08};
      }

      #input * {
        outline: 4px solid #${palette.base08}!important;
      }

      /* Text */
      #text {
        margin: 5px;
        border: none;
        color: #${palette.base05};
        animation: fadeIn 0.5s ease-in-out both;
      }

      #entry {
        border-radius: 0.6em;
        background-color: #${palette.base00};
      }

      #entry arrow {
        border: none;
        color: #${palette.base0D};
      }

      /* Selected Entry */
      #entry:selected {
        border: 0.11em solid #${palette.base0D};
      }

      #entry:selected #text {
        color: #${palette.base0D};
      }

      #entry:drop(active) {
        background-color: #${palette.base0D}!important;
      }
    '';
  };
}
