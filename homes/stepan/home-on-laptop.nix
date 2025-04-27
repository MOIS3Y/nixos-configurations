# █░█ █▀█ █▀▄▀█ █▀▀ ▄▄ █▀█ █▄░█ ▄▄ █░░ ▄▀█ █▀█ ▀█▀ █▀█ █▀█ ▀
# █▀█ █▄█ █░▀░█ ██▄ ░░ █▄█ █░▀█ ░░ █▄▄ █▀█ █▀▀ ░█░ █▄█ █▀▀ ▄
# -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -

{ ... }: {
  imports = [
    # Custom modules:
    ../../modules/desktop/laptop.nix
    # Shared configuration:
    ../_shared/desktop
    # Common users' home configuration:
    ./common.nix
  ];
}
