## Flake configurations

This repository contains the Nix flake configurations for my NixOS laptop. It's a heavily modified version of the original nixflk flake.

- `hosts`: Top-level definitions for each host managed by this repository.
- `lib`: Utility function library.
- `modules`: Nix modules that I have created.
- `overlays`: Package overlays for existing packages.
- `pkgs`: Nix packages that I have created.
- `profiles`: Machine-specific profiles.
- `secrets`: Secrets encrypted with git-crypt.
- `users/<user>`: User-specific profiles.
- `users/<user>/hosts/<host>`: User and machine specific profiles.

To build and switch to them, clone this repository and in `nix-shell` run `sudo nixos-rebuild switch`.

### New host deployment

1. Boot into installer
2. Connect to internet
3. Partition disks
```sh
DISK=/dev/disk/by-id/...
sgdisk -Z $DISK
sgdisk -a1 -n2:34:2047 -t2:EF02 $DISK
sgdisk -n3:1M:+512M -t3:EF00 $DISK
sgdisk -n1:0:0 -t1:BF01 $DISK

zpool create -o ashift=12 -O mountpoint=none -O atime=off -O xattr=sa -O acltype=posixacl -O encryption=aes-256-gcm -O keylocation=prompt -O keyformat=passphrase rpool $DISK-part1
zfs create -o mountpoint=legacy rpool/local
zfs create rpool/local/root
zfs create rpool/local/nix
zfs create -o mountpoint=legacy -o com.sun:auto-snapshot=true rpool/safe
zfs create rpool/safe/docker
zfs create -o compression=lz4 rpool/safe/home
zfs create rpool/safe/persist

zfs snapshot rpool/local/root@blank

mount -t zfs rpool/local/root /mnt
mount -t zfs rpool/safe/persist /mnt/persist

mkfs.vfat $DISK-part3
mkdir /mnt/boot
mount $DISK-part3 /mnt/boot

nixos-generate-config --root /mnt
```

4. Change any necessary defaults
5. Run nixos-install and reboot
6. Clone this repo into /persist/nixos
7. Run `sudo nixos-rebuild switch`
