# █▀█ █▀█ █▀█ █▀▀ █▀█ ▄▀█ █▀▄▀█ █▀ ▀
# █▀▀ █▀▄ █▄█ █▄█ █▀▄ █▀█ █░▀░█ ▄█ ▄
# -- -- -- -- -- -- -- -- -- -- -- -

# The module contains programs that are not in the home-manager repository.
# The path to activate options is standard programs.<name>.options
# If a program with the same name appears in the HM repository in the future,
# using a program from this module will cause a collision and will make
# the next generation build impossible or the program will be broken.
# In this case, you need to disable the import of the conflicting module here.
# The main recommendation is to use modules from
# the standard repository wherever possible.
# The module is just a temporary solution.

{ ... }: {
  imports = [
    ./mellowplayer.nix
    ./swappy.nix
  ];
}
