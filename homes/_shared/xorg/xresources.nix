# ▀▄▀ █▀█ █▀▀ █▀ █▀█ █░█ █▀█ █▀▀ █▀▀ █▀ ▀
# █░█ █▀▄ ██▄ ▄█ █▄█ █▄█ █▀▄ █▄▄ ██▄ ▄█ ▄
# -- -- -- -- -- -- -- -- -- -- -- -- -- 

{ config, pkgs, ... }: {
  xresources.extraConfig = ''
    Xft.dpi: 96
    Xft.antialias: true
    Xft.hinting: true
    Xft.rgba: rgb
    Xft.autohint: false
    Xft.hintstyle: hintfull
    Xft.lcdfilter: lcddefault

    *background: #${config.colorScheme.palette.base01}
    *foreground: #${config.colorScheme.palette.base05}

    ! black
    *color0: #${config.colorScheme.palette.base02}
    *color8: #${config.colorScheme.palette.base03}

    ! red
    *color1: #${config.colorScheme.palette.base08}
    *color9: #${config.colorScheme.palette.base08}

    ! green
    *color2: #${config.colorScheme.palette.base0B}
    *color10: #${config.colorScheme.palette.base0B}

    ! yellow
    *color3: #${config.colorScheme.palette.base0A}
    *color11: #${config.colorScheme.palette.base0A}

    ! blue
    *color4: #${config.colorScheme.palette.base0D}
    *color12: #${config.colorScheme.palette.base0D}

    ! magenta
    *color5: #${config.colorScheme.palette.base0E}
    *color13: #${config.colorScheme.palette.base0E}

    ! cyan
    *color6: #${config.colorScheme.palette.base0C}
    *color14: #${config.colorScheme.palette.base0C}

    ! white
    *color7: #${config.colorScheme.palette.base05}
    *color15: #${config.colorScheme.palette.base05}
  '';
}
