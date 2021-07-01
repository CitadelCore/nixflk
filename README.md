## Flake configurations

This repository contains the Nix flake configurations for my personal NixOS machines.

Once upon a time this was a modified version of `nixflk`, but after it deviated into devos I rewrote a lot of it myself.

See the Arnix repo for further documentation. To build and switch, clone this repository and run `nrb switch`.

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

sgdisk -a1 -n1:34:2047 -t1:EF02 $DISK
sgdisk -n2:1M:+512M -t2:EF00 $DISK
sgdisk -n3:513M:+32G -t3:8200 $DISK
sgdisk -n4:0:0 -t4:BF00 $DISK

mkfs.vfat $DISK-part2
mkswap -L swap $DISK-part3

zpool create -o ashift=12 -O mountpoint=none -O atime=off -O xattr=sa -O acltype=posixacl -O encryption=aes-256-gcm -O keylocation=prompt -O keyformat=passphrase rpool $DISK-part4
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
mount $DISK-part2 /mnt/boot

mkdir -p /mnt/etc/nixos
nixos-generate-config --root /mnt
```

4. Change any necessary defaults
5. Run nixos-install and reboot
6. Clone this repo into /persist/nixos
7. Run `sudo nixos-rebuild switch`
