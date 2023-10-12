<!-- NixOS configuration -->
<!-- https://github.com/MOIS3Y/dotfiles-nixos -->

<br>

<p align="center">
  <img src="https://raw.githubusercontent.com/NixOS/nixos-artwork/master/logo/nixos-white.png" width="500px" alt="NixOS logo"/>
</p>
<br>

<div>
<br>

## :wrench: <samp>Installation</samp>

1. Download iso:
   ```sh
   # Download nixos-stable
   wget -O nixos.iso https://channels.nixos.org/nixos-22.11/latest-nixos-gnome-x86_64-linux.iso

   # Write iso to a flash drive
   cp nixos.iso /dev/sdX
   ```

2. Boot into the installer

    2.1. Connect to Network
    
    2.2. Open terminal

3. Switch to root user: `sudo -i`

4. Partitioning:
    
    I am using nvme disk (/dev/nvme0n1) with GPT partition label: 
    ```bash
    # Final result:
    nvme0n1        259:0    0 210,0G  0 disk
    ├─nvme0n1p1    259:1    0    10G  0 part
    └─nvme0n1p2    259:2    0   200G  0 part
      ├─vg0-root   254:0    0    30G  0 lvm 
      ├─vg0-home   254:1    0    30G  0 lvm 
      └─vg0-swap   254:4    0    10G  0 lvm
    ```
    
    4.1. Create partitions
    ```bash
    # cfdisk (gpt + 2 part: 10Gb and all left space) / write (type yes) quit:
    cfdisk /dev/nvme0n1
    parted /dev/nvme0n1 name 1 EFI
    parted /dev/nvme0n1 name 2 SYSTEM
    
    # or only parted:
    parted /dev/nvme0n1 mklabel gpt
    parted /dev/nvme0n1 -- mkpart EFI fat32 1MB 10GB
    parted /dev/nvme0n1 -- mkpart SYSTEM 10GB 100%
    
    # require flag  for EFI boot partition: 
    parted /dev/nvme0n1 -- set 1 esp on
    ```
    
    4.2. Create LVM:
    ```bash
    pvcreate /dev/nvme0n1p2
    vgcreate vg0 /dev/nvme0n1p2
    lvcreate -L30G -n nixos vg0
    lvcreate -L30G -n home vg0
    lvcreate -L10G -n swap vg0
    lvcreate -L20G -n docker vg0
    ```
    
    4.3. Create filesystem:
    ```bash
    mkfs.ext4 -L nixos /dev/vg0/root
    mkfs.ext4 -L home /dev/vg0/home
    mkfs.ext4 -L docker /dev/vg0/home
    mkswap -L swap /dev/vg0/swap
    ``` 
    
    4.4. Mount:
    ```bash
    mkdir -p /mnt/{boot,home,var}
    mkdir -p /mnt/var/lib/docker
    mkdir -p /mnt/boot/efi
    
    mount /dev/disk/by-label/nixos /mnt
    mount /dev/disk/by-label/EFI /mnt/boot/efi
    mount /dev/disk/by-label/home /mnt/home
    mount /dev/disk/by-label/docker /mnt/var/lib/docker
    swapon /dev/disk/by-label/swap
    # See final result:
    lsblk
    
    ```
 
5. Enable flakes:
    ```bash
    nix-shell -p nixFlakes
    ```

6. Install nixos from flake:
    ```bash
    nixos-install --flake github:MOIS3Y/nixos-configurations#honor-wlr-w09 --impure
    ```
7. Fix GRUB (I have this trouble) after install:
    ```bash
    mkdir /mnt/boot/efi/EFI/boot
    cp /mnt/boot/efi/EFI/NixOS-boot-efi/grubx.efi /mnt/boot/efi/EFI/boot/bootx.efi
    ```
8. Umount:
    ```bash
    umount /mnt/boot/efi
    umount /mnt/var/lib/docker
    umount /mnt/home
    umount /mnt
    swapoff --all
    ```
9. Reboot:
    ```bash
    reboot
    # remove flash drive
    ```
<br>
</div>
