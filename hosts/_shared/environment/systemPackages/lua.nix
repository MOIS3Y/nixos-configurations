# █░░ █░█ ▄▀█ ▀
# █▄▄ █▄█ █▀█ ▄
# -- -- -- -- -

{ config, pkgs, ... }: {
  environment.systemPackages = with pkgs; [
    (lua.withPackages(ps: with ps; [ luarocks ]))
  ];
}
