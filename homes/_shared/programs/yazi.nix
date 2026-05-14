# █▄█ ▄▀█ ▀█ █ ▀
# ░█░ █▀█ █▄ █ ▄
# -- -- -- -- --
# Configuration for Yazi terminal file manager.

{ pkgs, ... }:
{
  programs.yazi = {
    enable = true;
    enableBashIntegration = true;
    enableZshIntegration = true;
    shellWrapperName = "y";

    extraPackages = with pkgs; [
      wl-clipboard
      dragon-drop
    ];

    initLua = ''
       require("full-border"):setup()

       function Linemode:size_and_mtime()
      	  local time = math.floor(self._file.cha.mtime or 0)
        	if time == 0 then
           time = ""
         elseif os.date("%Y", time) == os.date("%Y") then
           time = os.date("%b %d %H:%M", time)
         else
       		time = os.date("%b %d  %Y", time)
        	end

        	local size = self._file:size()
        	return string.format(
           "%s %s", size and ya.readable_size(size) or "-", time
         )
       end
    '';

    plugins = {
      full-border = pkgs.yaziPlugins.full-border;
    };

    settings = {
      mgr = {
        sort_by = "mtime";
        sort_sensitive = false;
        sort_reverse = true;
        sort_dir_first = true;
        linemode = "size_and_mtime";
      };
      opener = {
        edit = [
          {
            run = ''''${EDITOR:-vi} "$@"'';
            block = true;
            desc = "$EDITOR";
          }
        ];
        play = [
          {
            run = ''celluloid "$@"'';
            orphan = true;
            desc = "Celluloid";
          }
        ];
        image = [
          {
            run = ''imv "$@"'';
            orphan = true;
            desc = "IMV";
          }
        ];
        open = [
          {
            run = ''xdg-open "$@"'';
            desc = "Open";
          }
        ];
      };
      open = {
        prepend_rules = [
          {
            mime = "text/*";
            use = "edit";
          }
          {
            mime = "video/*";
            use = "play";
          }
          {
            mime = "audio/*";
            use = "play";
          }
          {
            mime = "image/*";
            use = "image";
          }
          {
            name = "*";
            use = "open";
          }
        ];
      };
    };

    keymap = {
      mgr = {
        prepend_keymap = [
          {
            on = [ "<C-n>" ];
            run = "shell -- dragon-drop -x -i -T %h";
            desc = "Drag and drop (dragon)";
          }
        ];
      };
    };
  };
}
