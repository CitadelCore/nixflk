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

### Sanity checks

Enable hooks for sanity checking:
`git config --local core.hooksPath .githooks/`

### New host deployment

1. Boot into installer
2. Connect to internet
3. Partition disks
```sh
DISK=/dev/disk/by-id/...
sgdisk -z $DISK

sgdisk -n1:1M:+512M -t1:EF00 $DISK
sgdisk -n2:0:+32G -t2:8200 $DISK
sgdisk -n3:0:0 -t3:BF00 $DISK

mkfs.vfat $DISK-part1
mkswap -L swap $DISK-part2

zpool create -o ashift=12 -O mountpoint=none -O atime=off -O xattr=sa -O acltype=posixacl -O encryption=aes-256-gcm -O keylocation=prompt -O keyformat=passphrase rpool $DISK-part3
zfs create -o mountpoint=legacy rpool/local
zfs create rpool/local/root
zfs create rpool/local/nix
zfs create rpool/local/docker
zfs create -o mountpoint=legacy -o com.sun:auto-snapshot=true rpool/safe
zfs create -o compression=lz4 rpool/safe/home
zfs create rpool/safe/persist
zfs snapshot rpool/local/root@blank

mount -t zfs rpool/local/root /mnt

cd /mnt
mkdir nix home persist boot
mount -t zfs rpool/local/nix /mnt/nix
mount -t zfs rpool/safe/home /mnt/home
mount -t zfs rpool/safe/persist /mnt/persist
mount $DISK-part1 /mnt/boot

mkdir -p /mnt/etc/nixos
nixos-generate-config --root /mnt
```

4. Change any necessary defaults
5. Run nixos-install and reboot
6. Clone this repo into /persist/nixos
7. Run `sudo nixos-rebuild switch`
