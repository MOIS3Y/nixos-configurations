# Installation Guide

This section covers the installation process for both physical desktop devices and Virtual Private Servers (VPS). 

> [!CAUTION]
> The `hardware-configuration.nix` files in this repository are strictly tied to my specific hardware. Using them directly on different devices will likely fail. You should generate your own hardware configuration or use this repository as a template.

---

## Desktop Installation

### 1. Prepare Installation Media
Download the latest NixOS ISO from the [official download page](https://nixos.org/download/). You can choose between the Minimal installer or a version with a desktop environment (GNOME/Plasma).

After downloading, write it to a flash drive using a utility like `dd`, BalenaEtcher, or Rufus.

### 2. Partitioning (Example with LVM)
I prefer LVM for flexibility, but you can use simple partitions (just `/` and `/home`, or even a single `/` root).

```console
# Create partition table and basic partitions
parted /dev/nvme0n1 mklabel gpt
parted /dev/nvme0n1 -- mkpart EFI fat32 1MB 10GB
parted /dev/nvme0n1 -- mkpart SYSTEM 10GB 100%
parted /dev/nvme0n1 -- set 1 esp on

# Setup LVM
pvcreate /dev/nvme0n1p2
vgcreate vg0 /dev/nvme0n1p2
lvcreate -L30G -n root vg0
lvcreate -L30G -n home vg0
lvcreate -L20G -n docker vg0
lvcreate -L10G -n swap vg0

# Formatting
mkfs.ext4 -L root /dev/vg0/root
mkfs.ext4 -L home /dev/vg0/home
mkfs.ext4 -L docker /dev/vg0/docker
mkswap -L swap /dev/vg0/swap

# Mounting the target system
mount /dev/disk/by-label/root /mnt
mkdir -p /mnt/{boot/efi,home,var/lib/docker}
mount /dev/disk/by-label/EFI /mnt/boot/efi
mount /dev/disk/by-label/home /mnt/home
mount /dev/disk/by-label/docker /mnt/var/lib/docker
swapon /dev/disk/by-label/swap
```

### 3. Hardware Configuration
Since your hardware will differ, you should generate a base configuration:
```console
nixos-generate-config --root /mnt
```
Then, you can copy the generated `/mnt/etc/nixos/hardware-configuration.nix` into the appropriate host directory in this repository (e.g., `hosts/your-host/`).

### 4. Install from Flake
In the live environment, you can enable flakes temporarily using an environment variable without modifying read-only system files:

```console
export NIX_CONFIG="experimental-features = nix-command flakes"
```

Run the installation targeting a specific host:
```console
nixos-install --flake github:MOIS3Y/nixos-configurations#laptop
```

---

## VPS Installation

Installing NixOS on a VPS often requires manual steps through a VNC console. Most VPS providers use **Legacy BIOS** (MBR) instead of UEFI.

### 1. Boot into ISO
Mount a NixOS ISO in your provider's control panel and access the machine via **VNC**.

### 2. Manual Network Setup
If DHCP is not available, configure the network manually:

```console
# 1. Identify your interface (e.g., ens3)
ip link

# 2. Assign IP address
ip addr add 1.2.3.4/24 dev ens3
ip link set ens3 up

# 3. Add default gateway
ip route add default via 1.2.3.1

# 4. Configure DNS
echo "nameserver 1.1.1.1" > /etc/resolv.conf
```

### 3. Partitioning (Legacy BIOS / MBR)
For a simple VPS setup without EFI, we use a MBR label and a single root partition with a swap file or partition.

```console
# Create MBR partition table
parted /dev/vda mklabel msdos
parted /dev/vda -- mkpart primary ext4 1MB 100%
parted /dev/vda -- set 1 boot on

# Formatting
mkfs.ext4 -L nixos /dev/vda1
# (Optional) Create swap partition if needed
# mkswap -L swap /dev/vda2

# Mounting
mount /dev/disk/by-label/nixos /mnt
```

### 4. Installation
Enable flakes and run the installation. Ensure your `boot.loader.grub.device` points to the correct disk (e.g., `/dev/vda`).

```console
export NIX_CONFIG="experimental-features = nix-command flakes"
nixos-install --flake github:MOIS3Y/nixos-configurations#gliese
```

### 5. Post-Install
After `reboot`, unmount the ISO in the provider's panel so the VPS boots from the disk.
