# █░█ █▀█ █▀▄▀█ █▀▀ ▄▄ █▀█ █▄░█ ▄▄ █░█░█ █▀█ █▀█ █▄▀ █▀ ▀█▀ ▄▀█ ▀█▀ █ █▀█ █▄░█ ▀
# █▀█ █▄█ █░▀░█ ██▄ ░░ █▄█ █░▀█ ░░ ▀▄▀▄▀ █▄█ █▀▄ █░█ ▄█ ░█░ █▀█ ░█░ █ █▄█ █░▀█ ▄
# -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- 

{ config, ... }: {
  imports = [
    # Custom modules:
    ../../modules/desktop/workstation.nix
    # Shared configuration:
    ../_shared/desktop
    # Common users' home configuration:
    ./common.nix
  ];
}
