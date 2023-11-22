# █▀ █▀█ █░█ █▄░█ █▀▄ ▀
# ▄█ █▄█ █▄█ █░▀█ █▄▀ ▄
# -- -- -- -- -- -- -- 

{ config, pkgs, ... }: {
  # Enable sound with pipewire.
  sound.enable = true;
  hardware.pulseaudio.enable = true;
  security.rtkit.enable = true;
  services.pipewire = {
    enable = false;
    alsa.enable = true;
    alsa.support32Bit = true;
    pulse.enable = true;
    # If you want to use JACK applications, uncomment this
    #jack.enable = true;
    
    # use the example session manager 
    # (no others are packaged yet so this is enabled by default,
    # no need to redefine it in your config for now)
    #media-session.enable = true;
  };
}
