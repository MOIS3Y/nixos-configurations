# █▀▄ █░█ █▄░█ █▀ ▀█▀ ▀
# █▄▀ █▄█ █░▀█ ▄█ ░█░ ▄
# -- -- -- -- -- -- -- 

{ config, pkgs, ... }: with config.desktop.utils; {
  dunst-volume = pkgs.writeShellScriptBin "dunst-volume.sh" ''
    ${pamixer} "$@"
    volume="$(${pamixer} --get-volume-human)"

    if [ "$volume" = "muted" ]; then
      ${notify-send} -r 69 \
        -a "Volume" \
        "Muted" \
        --expire-time=888 \
        --urgency=low
    else
      ${notify-send} -r 69 \
        -a "Volume" "Currently at $volume" \
        -h int:value:"$volume" \
        --expire-time=888 \
        --urgency=low
    fi
  '';
  dunst-microphone = pkgs.writeShellScriptBin "dunst-microphone.sh" ''
    ${pamixer} --default-source "$@"
    mic="$(${pamixer} --default-source --get-volume-human)"

    if [ "$mic" = "muted" ]; then
      ${notify-send} -r 69 \
        -a "Microphone" \
        "Muted" \
        --expire-time=888 \
        --urgency=low
    else
      ${notify-send} -r 69 \
        -a "Microphone" "Currently at $mic" \
        -h int:value:"$mic" \
        --expire-time=888 \
        --urgency=low
    fi
  '';
  dunst-brightness = pkgs.writeShellScriptBin "dunst-brightness.sh" ''
    ${brightnessctl} "$@"
    brightness=$(echo $(($(${brightnessctl} g) * 100 / $(${brightnessctl} m))))

    ${notify-send} -r 69 \
      -a "Brightness" "Currently at $brightness%" \
      -h int:value:"$brightness" \
      --expire-time=888 \
      --urgency=low
  '';
}
