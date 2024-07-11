# ▀▄▀ █▀█ █▀▀ █▀ █▀█ █░█ █▀█ █▀▀ █▀▀ █▀ ▀
# █░█ █▀▄ ██▄ ▄█ █▄█ █▄█ █▀▄ █▄▄ ██▄ ▄█ ▄
# -- -- -- -- -- -- -- -- -- -- -- -- -- 

{ config, pkgs, ... }: with config.colorScheme.palette; {
  xresources.extraConfig = ''
    Xft.dpi: 96
    Xft.antialias: true
    Xft.hinting: true
    Xft.rgba: rgb
    Xft.autohint: false
    Xft.hintstyle: hintfull
    Xft.lcdfilter: lcddefault

    *background: #${base01}
    *foreground: #${base05}

    ! black
    *color0: #${base02}
    *color8: #${base03}

    ! red
    *color1: #${base08}
    *color9: #${base08}

    ! green
    *color2: #${base0B}
    *color10: #${base0B}

    ! yellow
    *color3: #${base0A}
    *color11: #${base0A}

    ! blue
    *color4: #${base0D}
    *color12: #${base0D}

    ! magenta
    *color5: #${base0E}
    *color13: #${base0E}

    ! cyan
    *color6: #${base0C}
    *color14: #${base0C}

    ! white
    *color7: #${base05}
    *color15: #${base05}
  '';
}
