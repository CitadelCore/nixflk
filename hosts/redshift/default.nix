{ lib, pkgs, repos, ... }:
let
    inherit (lib.arnix) mkProf;
in {
    imports = (with repos.root; mkProf [
        profiles.core.ephemeral
        profiles.core.security.tpm
        profiles.core.zfs
        profiles.locales.gb
        profiles.virt.docker
        profiles.virt.libvirt
        profiles.graphical
        profiles.graphical.gnome
        profiles.graphical.wayland
    ]) ++ (with repos.self; mkProf [
        users.alex
        profiles.laptop
        profiles.roles.dev
        profiles.hardware.system.p15v
    ]);

    boot = {
        initrd = {
            availableKernelModules = [
                "xhci_pci"
                "nvme"
                "usb_storage"
                "sd_mod"
                "rtsx_pci_sdmmc"
            ];
            
            kernelModules = [ "dm-snapshot" ];
        };

        loader.efi.canTouchEfiVariables = true;
        kernelModules = [ "kvm-intel" ];
    };

    fileSystems = {
        "/var/lib/docker" = {
            device = "rpool/local/docker";
            fsType = "zfs";
        };

        "/boot" = {
            device = "/dev/disk/by-uuid/0ECD-3BA9";
            fsType = "vfat";
        };
    };

    swapDevices = [{
        device = "/dev/disk/by-partuuid/98e7dbe7-570e-4876-9d03-608e032f1a01";
        randomEncryption.enable = true;
    }];

    networking.hostId = "b72a26e5";

    environment.systemPackages = with pkgs; [
        gnome3.gnome-tweaks
    ];
}
