# ▀█▀ █░█ █▀▀ █▀▄▀█ █▀▀ █▀ ▀
# ░█░ █▀█ ██▄ █░▀░█ ██▄ ▄█ ▄
# -- -- -- -- -- -- -- -- --

{ pkgs, ... }: with pkgs; {
  # Distro:
  nixos = fetchzip {
    name = "grub-theme-nixos";
    url = "https://github.com/AdisonCavani/distro-grub-themes/releases/download/v3.2/nixos.tar";
    hash = "sha256-KQAXNK6sWnUVwOvYzVfolYlEtzFobL2wmDvO8iESUYE=";
    stripRoot = false;
  };
  # Vendor:
  gigabyte = fetchzip {
    name = "grub-theme-gigabyte";
    url = "https://github.com/AdisonCavani/distro-grub-themes/releases/download/v3.2/gigabyte.tar";
    hash = "sha256-fqftm2isXJu0e+2i+kCrF4AVHESp4goz6aXLDII1NXc=";
    stripRoot = false;
  };
  huawei = fetchzip {
    name = "grub-theme-huawei";
    url = "https://github.com/AdisonCavani/distro-grub-themes/releases/download/v3.2/huawei.tar";
    hash = "sha256-aKMJZJO+PNSbPn9yrVfaaCD/tVZIAPuYYpCSG+zsg80";
    stripRoot = false;
  };
  msi = fetchzip {
    name = "grub-theme-msi";
    url = https://github.com/AdisonCavani/distro-grub-themes/releases/download/v3.2/msi.tar;
    hash = "sha256-4+DzRtdu8F9RRR+XrN8SPPnUOVOIgHr2vYOPqI1vcDM=";
    stripRoot = false;
  };
}
